resource "aws_iam_role" "app" {
  name = "${lower(var.project_name)}-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name    = "${lower(var.project_name)}-app-role"
    Project = var.project_name
  }
}

resource "aws_iam_instance_profile" "app" {
  name = "${lower(var.project_name)}-app-profile"
  role = aws_iam_role.app.name

  tags = {
    Name    = "${lower(var.project_name)}-app-profile"
    Project = var.project_name
  }
}

resource "aws_iam_role_policy_attachment" "ecr_read" {
  role       = aws_iam_role.app.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.app.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy" "app_inline" {
  name = "${lower(var.project_name)}-app-inline"
  role = aws_iam_role.app.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "ReadDbSecret"
        Effect   = "Allow"
        Action   = "secretsmanager:GetSecretValue"
        Resource = module.database.db_master_secret_arn
      },
      {
        Sid      = "WriteReports"
        Effect   = "Allow"
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.runtime.arn}/reports/*"
      }
    ]
  })
}