resource "aws_route53_record" "admin" {
  zone_id = data.terraform_remote_state.network.outputs.hosted_zone_id
  name    = data.terraform_remote_state.certs.outputs.server_dns_prefix
  type    = "A"

  alias {
    name                   = aws_elb.nomad_server.dns_name
    zone_id                = aws_elb.nomad_server.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "client" {
  zone_id = data.terraform_remote_state.network.outputs.hosted_zone_id
  name    = data.terraform_remote_state.certs.outputs.client_dns_prefix
  type    = "A"

  alias {
    name                   = aws_elb.nomad_client.dns_name
    zone_id                = aws_elb.nomad_client.zone_id
    evaluate_target_health = true
  }
}