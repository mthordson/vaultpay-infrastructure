resource "aws_autoscaling_group" "app" {
  name                = "${lower(var.project_name)}-app-asg"
  vpc_zone_identifier = module.vpc.app_private_subnet_ids
  desired_capacity    = 2
  min_size            = 2
  max_size            = 2

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  target_group_arns         = [aws_lb_target_group.app.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Project"
    value               = lower(var.project_name)
    propagate_at_launch = true
  }
}
