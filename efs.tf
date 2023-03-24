resource "aws_efs_file_system" "efs" {
  performance_mode = var.performance_mode
  throughput_mode  = var.throughput_mode

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  tags                            = merge({ Name = var.efs_name }, { for k, v in var.efs_tags : k => tostring(v) })
  encrypted                       = true
  provisioned_throughput_in_mibps = 0
  creation_token                  = var.efs_name
}

resource "aws_efs_mount_target" "mount_target" {
  for_each       = { for az, subnet_id in var.subnets : az => subnet_id }
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = each.value
  security_groups = [
    element(var.security_groups, index(var.azs, each.key)),
  ]
}