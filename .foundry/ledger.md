# Foundry Ledger

## 2026-06-26.create.foundation

- Kind: create
- Change Package: none
- Related files: .foundry/manifest.yaml, scripts/gate.sh
- Decision: Created as a Foundry Foundation child.
- Reason: Establishes lineage, governance, and gate contracts before recipe capabilities are added.


## 2026-06-26.capability-addition.aws-account

- Kind: capability-addition
- Change Package: none
- Related files: .foundry/manifest.yaml
- Decision: Added Foundry Capability aws:account.
- Reason: Capability Addition records the selected Foundry-owned capability before provider automation is introduced.


## 2026-06-26.capability-addition.secrets-onepassword

- Kind: capability-addition
- Change Package: none
- Related files: .foundry/manifest.yaml
- Decision: Added Foundry Capability secrets:onepassword.
- Reason: Capability Addition records the selected Foundry-owned capability before provider automation is introduced.


## 2026-06-26.capability-addition.aws-terraform-identity

- Kind: capability-addition
- Change Package: none
- Related files: .foundry/manifest.yaml
- Decision: Added Foundry Capability aws:terraform-identity.
- Reason: Capability Addition records the selected Foundry-owned capability before provider automation is introduced.


## 2026-06-26.capability-addition.infra-terraform-s3-backend

- Kind: capability-addition
- Change Package: none
- Related files: .foundry/manifest.yaml
- Decision: Added Foundry Capability infra:terraform-s3-backend.
- Reason: Capability Addition records the selected Foundry-owned capability before provider automation is introduced.


## 2026-06-26.provider-bootstrap.aws-terraform-s3-backend

- Kind: provider-bootstrap-plan
- Change Package: none
- Related files: .foundry/bootstrap/aws-terraform-s3-backend
- Decision: Generated AWS Terraform S3 backend bootstrap plan.
- Reason: The plan is a reviewable AWS CLI script for creating the OIDC provider, role, state bucket, and scoped state policy without committing credential material.


## 2026-06-26.provider-bootstrap-apply.aws-terraform-s3-backend

- Kind: provider-bootstrap-apply
- Change Package: none
- Related files: .foundry/bootstrap/aws-terraform-s3-backend/plan.sh
- Decision: Applied AWS Terraform S3 backend bootstrap plan.
- Reason: The live AWS bootstrap script was run only after Foundry regenerated and validated the reviewable plan.
