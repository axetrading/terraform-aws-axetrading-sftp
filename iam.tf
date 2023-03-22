resource "aws_iam_role" "sftp_user_role" {
  count = var.create_sftp_server ? 1 : 0

  name = "${var.sftp_name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "transfer.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "sftp_user_policy" {
  count = var.create_sftp_server ? 1 : 0

  name   = "${var.sftp_name}-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.sftp_user_policy[count.index].json
}

data "aws_iam_policy_document" "sftp_user_policy" {
  count = var.create_sftp_server ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientRootAccess",
      "elasticfilesystem:ClientRead",
      "elasticfilesystem:ClientExecute",
      "elasticfilesystem:DescribeMountTargets",
      "elasticfilesystem:ClientWrite"
    ]

    resources = [
      aws_efs_file_system.efs[0].arn
    ]
  }
}

resource "aws_iam_role_policy_attachment" "sftp_user_policy_attachment" {
  count      = var.create_sftp_server ? 1 : 0
  policy_arn = aws_iam_policy.sftp_user_policy[count.index].arn
  role       = aws_iam_role.sftp_user_role[count.index].name
}
