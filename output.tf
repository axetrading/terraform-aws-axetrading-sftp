output "efs_file_system_arns" {
  value = aws_efs_file_system.efs.*.arn
}

output "efs_file_system_ids" {
  value = aws_efs_file_system.efs.*.id
}

output "efs_file_system_dns_names" {
  value = aws_efs_file_system.efs.*.dns_name
}

output "efs_mount_target_ids" {
  value = aws_efs_mount_target.mount_target.*.id
}

output "efs_mount_target_dns_names" {
  value = aws_efs_mount_target.mount_target.*.dns_name
}
