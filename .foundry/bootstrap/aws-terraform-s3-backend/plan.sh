#!/usr/bin/env sh
set -eu

root="$(CDPATH= cd -- "$(dirname -- "$0")/../../.." && pwd)"
plan_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
profile="agent-admin"
region="eu-west-1"
expected_account="273613910635"
bucket="foundry-tfstate-273613910635-eu-west-1-foundry-terraform-smoke"
role_name="foundry-terraform-smoke"
oidc_provider_arn="arn:aws:iam::273613910635:oidc-provider/token.actions.githubusercontent.com"
trust_policy="$root/infra/aws/terraform-identity-trust-policy.json"
state_policy="$plan_dir/terraform-state-policy.json"

actual_account="$(aws sts get-caller-identity --profile "$profile" --query Account --output text)"
if [ "$actual_account" != "$expected_account" ]; then
  echo "AWS CLI profile $profile resolved account $actual_account, expected $expected_account" >&2
  exit 1
fi

if aws iam get-open-id-connect-provider --open-id-connect-provider-arn "$oidc_provider_arn" --profile "$profile" >/dev/null 2>&1; then
  echo "GitHub OIDC provider already exists: $oidc_provider_arn"
else
  aws iam create-open-id-connect-provider \
    --url https://token.actions.githubusercontent.com \
    --client-id-list sts.amazonaws.com \
    --profile "$profile"
fi

aws iam add-client-id-to-open-id-connect-provider \
  --open-id-connect-provider-arn "$oidc_provider_arn" \
  --client-id sts.amazonaws.com \
  --profile "$profile"

if aws iam get-role --role-name "$role_name" --profile "$profile" >/dev/null 2>&1; then
  aws iam update-assume-role-policy --role-name "$role_name" --policy-document "file://$trust_policy" --profile "$profile"
else
  aws iam create-role --role-name "$role_name" --assume-role-policy-document "file://$trust_policy" --profile "$profile"
fi

aws iam put-role-policy --role-name "$role_name" --policy-name foundry-terraform-state --policy-document "file://$state_policy" --profile "$profile"

if aws s3api head-bucket --bucket "$bucket" --profile "$profile" >/dev/null 2>&1; then
  echo "S3 state bucket already exists: $bucket"
elif [ "$region" = "us-east-1" ]; then
  aws s3api create-bucket --bucket "$bucket" --region "$region" --profile "$profile"
else
  aws s3api create-bucket --bucket "$bucket" --region "$region" --create-bucket-configuration LocationConstraint="$region" --profile "$profile"
fi

aws s3api put-bucket-versioning \
  --bucket "$bucket" \
  --versioning-configuration Status=Enabled \
  --profile "$profile"

aws s3api put-bucket-encryption \
  --bucket "$bucket" \
  --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}' \
  --profile "$profile"

aws s3api put-public-access-block \
  --bucket "$bucket" \
  --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true \
  --profile "$profile"
