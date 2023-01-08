resource "aws_alb" "webapp_load_balancer" {
  name               = "Production-Webbapp-LoadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ELB_SG.id]

tags = {
    Name = "webapp_load_balancer_TF"
  }
  subnets = "${aws_subnet.public_subnets.*.id}"
  depends_on = [
    aws_subnet.public_subnets,
    aws_security_group.ELB_SG
  ]
}

# ------ Target Group for Load Balancer ------

resource "aws_alb_target_group" "LB_TG" {
  name     = "LB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.mainvpc.id
  health_check {
                path = "/"
                port = "80"
                protocol = "HTTP"
                healthy_threshold = 5
                unhealthy_threshold = 2
                interval = 5
                timeout = 4
                matcher = "200"
        }
  tags = {
    name = "alb-front-http"
  }
  depends_on = [
    aws_vpc.mainvpc
  ]
}

resource "aws_alb_target_group_attachment" "targetgroup_alb" {
  target_group_arn = "${aws_alb_target_group.LB_TG.arn}"
  count    = "${length(var.public_subnet_cidr)}"
  port     = 80
  target_id        = "${element(aws_instance.PublicEC2.*.id, count.index)}"
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.webapp_load_balancer.arn}"
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.LB_TG.arn}"
  } 
  depends_on = [
            aws_alb.webapp_load_balancer,
            aws_alb_target_group.LB_TG
              ]
}
