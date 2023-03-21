resource "aws_iam_role" "sftp_role" {
  count = var.create_sftp_server ? 1 : 0

  name = "${var.sftp_name}-${count.index}"
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

resource "aws_iam_policy" "sftp_policy" {
  count = var.create_sftp_server ? 1 : 0

  name   = "${var.sftp_name}-${count.index}"
  path   = "/"
  policy = data.aws_iam_policy_document.sftp_policy[count.index].json
}

data "aws_iam_policy_document" "sftp_policy" {
  count = var.create_sftp_server ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "transfer:ListUsers",
      "transfer:CreateUser",
      "transfer:DeleteUser",
      "transfer:UpdateUser",
      "transfer:CreateServer",
      "transfer:DeleteServer",
      "transfer:DescribeServer",
      "transfer:DescribeUser",
      "transfer:ImportSshPublicKey",
      "transfer:DescribeImportSshPublicKeyTasks",
      "transfer:TagResource",
      "transfer:UntagResource",
      "iam:PassRole",
    ]

    resources = [
      aws_transfer_server.sftp_server[count.index].arn,
      aws_iam_role.sftp_role[count.index].arn,
    ]
  }
}

# Attach SFTP Policy to SFTP Role
resource "aws_iam_role_policy_attachment" "sftp_policy_attachment" {
  count = var.create_sftp_server ? 1 : 0

  policy_arn = aws_iam_policy.sftp_policy[count.index].arn
  role       = aws_iam_role.sftp_role[count.index].name
}