/* resource "aws_iam_role" "transfer_role" {
  name = "transfer-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "transfer.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "transfer_policy" {
  name        = "transfer-policy"
  description = "Policy for Transfer user"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:DescribeFileSystems"
        ]
        Resource  = aws_efs_file_system.efs[0].arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "transfer_role_policy_attachment" {
  policy_arn = aws_iam_policy.transfer_policy.arn
  role       = aws_iam_role.transfer_role.name
} */