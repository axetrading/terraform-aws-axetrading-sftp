/**
 * # AWS SFTP with EFS Terraform Module
 *
 * This module set up EFS with AWS Transfer Family for accessing AxeTrading server files for managed service customers.
 *
 * # Connect to sftp server: 
 *
 * sftp -i path-to-private-key sftp-username@sftp-server-address
 *
 * # Mounting instructions:
 *
 * Run the following command to install the amazon-efs-utils package: sudo yum install -y amazon-efs-utils
 *
 * sudo mount -t efs -o tls EFS_ID:/ EFS_ID
 *
 * sudo chown -R ec2-user:ec2-user EFS_ID
 *
 * sudo chmod -R 755 EFS_ID
 */

locals {
  role_arn = var.create_iam_role ? aws_iam_role.sftp_user_role[0].arn : var.provided_iam_role_arn
}

# Create AWS Transfer Family SFTP Server
resource "aws_transfer_server" "sftp_server" {
  lifecycle {
    create_before_destroy = true
  }
  identity_provider_type = var.identity_provider_type
  endpoint_type          = var.endpoint_type
  domain                 = var.sftp_domain
  tags                   = merge({ Name = var.sftp_name }, var.tags)
}

# Create AWS Transfer Family SFTP User
resource "aws_transfer_user" "sftp_user" {
  for_each = var.sftp_users

  server_id = aws_transfer_server.sftp_server.id
  user_name = each.key

  home_directory_type = var.home_directory_type
  home_directory = "${aws_efs_file_system.efs.id}/${each.key}"

  posix_profile {
    uid = each.value.uid
    gid = each.value.gid
  }

  role = local.role_arn

  tags = {
    Name = each.key
  }

}

### Asociate SFTP User with his ssh public key
resource "aws_transfer_ssh_key" "sftp_ssh_key" {
  for_each  = var.sftp_users
  server_id = aws_transfer_server.sftp_server.id
  user_name = each.key
  body      = each.value.public_key
  depends_on = [
    aws_transfer_user.sftp_user
  ]
}


