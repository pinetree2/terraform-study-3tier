
#alb - web 에 접근 - web 을 가진 private subnet으로 설정
resource "aws_lb" "external-alb"{
    name = "external-LB"
    internal = false 
    load_balancer_type = "application"
    security_groups = [var.security_group_id]
    subnets = [var.private_subnet_id[0],var.private_subnet_id[1]]
    enable_deletion_protection = true
    tags = {Name = "song-lb"}


}

resource "aws_lb_target_group" "target-elb"{

  # 서비스 포트 설정 
  name     = "SONG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  tags = {Name = "song-lb-tg"}

}

resource "aws_lb_target_group_attachment" "attachment1" {
  target_group_arn = aws_lb_target_group.target-elb.arn
  target_id        = var.private_instance_id[0]
  port             = 80

}
resource "aws_lb_target_group_attachment" "attachment2" {
  target_group_arn = aws_lb_target_group.target-elb.arn
  target_id        = var.private_instance_id[1]
  port             = 80

}



resource "aws_lb_listener" "internal_80" {
  load_balancer_arn = aws_lb.external-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.target-elb.arn
    type             = "forward"
  }
}