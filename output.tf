### EFS 
output "efs_file_system_arns" {
  value       = aws_efs_file_system.efs.*.arn
  description = "ARN of EFS"
}

output "efs_file_system_ids" {
  value       = aws_efs_file_system.efs.*.id
  description = "ID of EFS"
}

output "efs_file_system_dns_names" {
  value       = aws_efs_file_system.efs.*.dns_name
  description = "DNS NAME of EFS"
}

output "efs_mount_target_ids" {
  value       = aws_efs_mount_target.mount_target.*.id
  description = "MOUNT TARGED ID of EFS"
}

output "efs_mount_target_dns_names" {
  value       = aws_efs_mount_target.mount_target.*.dns_name
  description = "DNS NAME of EFS Mount Target"
}

### SFTP 
output "sftp_user_key" {
  value       = tls_private_key.sftp_key.private_key_pem
  description = "SSH Private Key for SFTP User"
}

output "sftp_server_id" {
  value       = aws_transfer_server.sftp_server[0].id
  description = "ID of SFTP server"
}

output "sftp_user_id" {
  value       = aws_transfer_user.sftp_user[0].id
  description = "ID of SFTP user"
}

output "sftp_user_name" {
  value       = aws_transfer_user.sftp_user[0].user_name
  description = "NAME of SFTP user"
}

output "sftp_user_home_directory" {
  value       = aws_transfer_user.sftp_user[0].home_directory
  description = "HOME_DIR for SFTP user"
}

