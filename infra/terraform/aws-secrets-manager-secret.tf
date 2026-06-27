resource "aws_secretsmanager_secret" "foundry_managed" {
  name                    = "/foundry/smoke/api-key"
  recovery_window_in_days = 0

  tags = {
    ManagedBy = "project-foundry"
  }
}

output "foundry_managed_secret_name" {
  value = aws_secretsmanager_secret.foundry_managed.name
}

output "foundry_managed_secret_arn" {
  value = aws_secretsmanager_secret.foundry_managed.arn
}
