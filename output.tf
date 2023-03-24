### EFS 
output "efs_file_system_id" {
  value = try(aws_efs_file_system.efs[*].id, "")
}

output "efs_mount_target_ids" {
  value = try(aws_efs_mount_target.mount_target[*].id, "")
}

output "efs_mount_target_dns_names" {
  value = try(aws_efs_mount_target.mount_target[*].dns_name, "")
}

### SFTP 
output "sftp_server_arn" {
  value = aws_transfer_server.sftp_server.arn
}

output "sftp_server_id" {
  value = aws_transfer_server.sftp_server.id
}

output "sftp_user_usernames" {
  value = [for user in aws_transfer_user.sftp_user : user.user_name]
}

### IAM
output "iam_role_arn" {
  value = aws_iam_role.sftp_user_role[0].arn
}