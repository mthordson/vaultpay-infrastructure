data "aws_ssm_parameter" "al2023_arm" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-arm64"
}

data "aws_region" "current" {}

resource "aws_security_group" "app" {
  name        = "${lower(var.project_name)}-app-sg"
  description = "Security group for the Vaultpay app instances"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${lower(var.project_name)}-app-sg"
    Project = var.project_name
  }
}

resource "aws_launch_template" "app" {
  name_prefix   = "${var.project_name}-app-"
  image_id      = data.aws_ssm_parameter.al2023_arm.value
  instance_type = "t4g.small"

  iam_instance_profile {
    name = aws_iam_instance_profile.app.name
  }

  vpc_security_group_ids = [aws_security_group.app.id]

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    aws_region           = data.aws_region.current.region
    ecr_registry         = split("/", aws_ecr_repository.vaultpay.repository_url)[0]
    ecr_repository_url   = aws_ecr_repository.vaultpay.repository_url
    image_tag            = var.image_tag
    db_master_secret_arn = module.database.db_master_secret_arn
    db_host              = split(":", module.database.db_endpoint)[0]
    db_port              = module.database.db_port
    db_name              = module.database.db_name
    artifact_bucket_name = aws_s3_bucket.runtime.id
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "${lower(var.project_name)}-app"
      Project = var.project_name
    }
  }

  tags = {
    Name    = "${lower(var.project_name)}-app-lt"
    Project = var.project_name
  }
}