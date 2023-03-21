### EFS 

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

### SFTP 

# Output RSA Key for SFTP User
output "sftp_user_key" {
  value = tls_private_key.sftp_key.private_key_pem
}

output "sftp_server_id" {
  value = aws_transfer_server.sftp_server[0].id
}

output "sftp_user_id" {
  value = aws_transfer_user.sftp_user[0].id
}

output "sftp_user_name" {
  value = aws_transfer_user.sftp_user[0].user_name
}

output "sftp_user_home_directory" {
  value = aws_transfer_user.sftp_user[0].home_directory
}

