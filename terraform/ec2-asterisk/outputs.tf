# ─────────────────────────────────────────────
# FILE: variables.tf
# ─────────────────────────────────────────────

# variables.tf
output "instance_public_ip" {
  value = aws_instance.asterisk.public_ip
}

output "instance_id" {
  value = aws_instance.asterisk.id
}
