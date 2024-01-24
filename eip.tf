resource "aws_eip" "eip" {
  count = var.is_public ? length(var.subnets) : 0

  vpc = var.vpc_id

  tags = var.tags
}