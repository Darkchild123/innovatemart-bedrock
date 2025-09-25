# IAM User for Developers (Read-only access)
resource "aws_iam_user" "developer" {
  name = "innovatemart-developer"
  tags = {
    Project = "innovatemart"
    Role    = "readonly"
  }
}

# IAM Policy for Developer Read-only Access
resource "aws_iam_user_policy" "developer_readonly" {
  name = "EKS-ReadOnly-Access"
  user = aws_iam_user.developer.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:DescribeCluster",
          "eks:ListClusters"
        ]
        Resource = "*"
      }
    ]
  })
}

# Generate Access Keys for Developer
resource "aws_iam_access_key" "developer" {
  user = aws_iam_user.developer.name
}
