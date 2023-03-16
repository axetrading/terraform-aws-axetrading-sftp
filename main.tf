/**
 * # AWS SFTP Terraform Module
 *
 * This module set up EFS with AWS Transfer Family for accessing AxeTrading server files for managed service customers.
 *
 */


### EFS
resource "aws_efs_file_system" "efs" {
  count = length(var.az)

  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  tags = {
    Name        = "${var.efs_name}-${count.index}"
    Customer    = "customer"
    Backup      = "true"
    Environment = "dev"
  }

  encrypted                       = true
  provisioned_throughput_in_mibps = 0
  creation_token                  = "${var.efs_name}-${count.index}"
  availability_zone_name          = var.az[count.index]
}

resource "aws_efs_mount_target" "mount_target" {
  count = var.subnets != [] && var.security_groups != [] ? length(var.subnets) : 0

  file_system_id = aws_efs_file_system.efs[count.index % length(aws_efs_file_system.efs)].id
  subnet_id      = var.subnets[count.index]

  security_groups = [
    var.security_groups[0].id,
  ]
}





