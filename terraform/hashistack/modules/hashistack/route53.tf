resource "aws_route53_record" "www" {
  zone_id = data.terraform_remote_state.network.outputs.hosted_zone_id
  name    = "example.com"
  type    = "A"

  alias {
    name                   = aws_elb.nomad_server.dns_name
    zone_id                = aws_elb.nomad_server.zone_id
    evaluate_target_health = true
  }
}