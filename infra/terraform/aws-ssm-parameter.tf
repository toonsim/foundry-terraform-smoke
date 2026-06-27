resource "aws_ssm_parameter" "foundry_managed" {
  name  = "/foundry/smoke/config"
  type  = "String"
  value = "hello-foundry"

  tags = {
    ManagedBy = "project-foundry"
  }
}

output "foundry_managed_ssm_parameter_name" {
  value = aws_ssm_parameter.foundry_managed.name
}
