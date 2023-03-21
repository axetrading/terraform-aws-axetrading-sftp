/**
 * # AWS SFTP Terraform Module
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
  tags = {
    Name        = "${var.sftp_name}-${count.index}"
    Customer    = "customer"
    Backup      = "true"
    Environment = "dev"
  }
}

# Create AWS Transfer Family SFTP User
resource "aws_transfer_user" "sftp_user" {
  count = var.create_sftp_server ? 1 : 0

  server_id = aws_transfer_server.sftp_server[count.index].id
  user_name = var.sftp_user_name

  home_directory = "/${aws_efs_file_system.efs[count.index % length(aws_efs_file_system.efs)].id}"

  role = aws_iam_role.sftp_role[count.index].arn


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


# Associate SFTP User with SFTP Server
resource "aws_transfer_ssh_key" "sftp_ssh_key" {
  count = var.create_sftp_server ? 1 : 0

  server_id = aws_transfer_server.sftp_server[count.index].id
  /* user_name = aws_transfer_user.sftp_user[count.index].name */
  user_name = aws_transfer_user.sftp_user[count.index].user_name


  body = tls_private_key.sftp_key.public_key_openssh
}

# Mount EFS on SFTP server
/* resource "null_resource" "mount_efs" {
  count = var.create_sftp_server ? 1 : 0

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y amazon-efs-utils",
      "sudo mkdir /mnt/efs",
      "sudo chmod 777 /mnt/efs/",
      "sudo mount -t efs ${aws_efs_file_system.efs[count.index % length(aws_efs_file_system.efs)].id}:/ /mnt/efs"
    ]

    connection {
      type        = "ssh"
      host        = aws_transfer_server.sftp_server[count.index].endpoint
      user        = "user1"
      private_key = tls_private_key.sftp_key.private_key_pem
    }
  }
} */


