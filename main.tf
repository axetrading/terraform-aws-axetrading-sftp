/**
 * # AWS SFTP with EFS Terraform Module
 *
 * This module set up EFS with AWS Transfer Family for accessing AxeTrading server files for managed service customers.
 * In this way you connect to sftp server: sftp -i <path-to-private-key> <username>@<server-address>
 *
 */


# Create AWS Transfer Family SFTP Server
resource "aws_transfer_server" "sftp_server" {
  count = var.create_sftp_server ? 1 : 0

  identity_provider_type = "SERVICE_MANAGED"
  endpoint_type          = "PUBLIC"
  domain                 = "EFS"

  tags = {
    Name = "${var.sftp_name}-${count.index}"
  }
}

# Create AWS Transfer Family SFTP User
resource "aws_transfer_user" "sftp_user" {
  count = var.create_sftp_user ? 1 : 0

  server_id = aws_transfer_server.sftp_server[count.index].id
  user_name = var.sftp_user_name

  home_directory_type = "LOGICAL"
  home_directory_mappings {
    entry  = "/"
    target = "/${aws_efs_file_system.efs[count.index % length(aws_efs_file_system.efs)].id}"
  }
  posix_profile {
    uid = 1000
    gid = 1000
  }

  role = aws_iam_role.sftp_user_role[count.index].arn
  tags = {
    Name        = "${var.sftp_user_name}-${count.index}"
    Customer    = "customer"
    Backup      = "true"
    Environment = "dev"
  }
}

# Generate RSA Key for SFTP User
resource "tls_private_key" "sftp_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Associate SFTP User key with SFTP Server
resource "aws_transfer_ssh_key" "sftp_ssh_key" {
  count     = var.create_sftp_user ? 1 : 0
  server_id = aws_transfer_server.sftp_server[count.index].id
  user_name = aws_transfer_user.sftp_user[count.index].user_name
  body      = tls_private_key.sftp_key.public_key_openssh
}




