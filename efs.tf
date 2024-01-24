resource "aws_efs_file_system" "efs" {
  creation_token                  = var.efs_name
  encrypted                       = true
  performance_mode                = var.performance_mode
  provisioned_throughput_in_mibps = 0
  tags                            = merge({ Name = var.efs_name }, var.tags)
  throughput_mode                 = var.throughput_mode
}

resource "aws_efs_mount_target" "mount_target" {
  for_each        = toset(var.subnets)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = each.value
  security_groups = var.create_efs_security_group ? compact(concat([aws_security_group.efs[0].id], var.security_groups)) : var.security_groups
}