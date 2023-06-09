### EFS 
output "efs_file_system_id" {
  description = "EFS ID"
  value       = try(aws_efs_file_system.efs[*].id, "")
}

output "efs_mount_target_ids" {
  description = "EFS Mount targets"
  value       = try(values(aws_efs_mount_target.mount_target)[*].id, [])

}

output "efs_mount_target_dns_names" {
  description = "EFS Mount targets DNS name"
  value       = try(values(aws_efs_mount_target.mount_target)[*].dns_name, [])
}

### SFTP 
output "sftp_server_arn" {
  description = "SFTP SERVER ARN"
  value       = aws_transfer_server.sftp_server.arn
}

output "sftp_server_id" {
  description = "SFTP SERVER ID"
  value       = aws_transfer_server.sftp_server.id
}

output "sftp_user_usernames" {
  description = "SFTP SERVER USERS"
  value       = [for user in aws_transfer_user.sftp_user : user.user_name]
}

### IAM
output "iam_role_arn" {
  description = "IAM ROLE ARN used for SFTP users"
  value       = aws_iam_role.sftp_user_role[0].arn
}