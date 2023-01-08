output "vpc_id" {
  value = aws_vpc.mainvpc.id
}
output "alb_dns" {
  value = aws_alb.webapp_load_balancer.dns_name
}