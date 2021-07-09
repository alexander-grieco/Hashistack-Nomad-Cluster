resource "aws_elb_attachment" "nomad_server" {
  count = var.server_count

  elb      = aws_elb.nomad_server.id
  instance = aws_instance.nomad_server[count.index].id
}

resource "aws_elb" "nomad_server" {
  name         = "${var.stack_name}-nomad-server"
  subnets      = var.subnet_ids
  internal     = false
  idle_timeout = 360

  listener {
    instance_port     = 4646
    instance_protocol = "http"
    lb_port           = 4646
    lb_protocol       = "http"
  }

  listener {
    instance_port     = 8500
    instance_protocol = "http"
    lb_port           = 8500
    lb_protocol       = "http"
  }
  security_groups = [aws_security_group.server_lb.id]
}

resource "aws_elb" "nomad_client" {
  name     = "${var.stack_name}-nomad-client"
  subnets  = var.subnet_ids
  internal = false
  listener {
    instance_port     = 8500
    instance_protocol = "http"
    lb_port           = 8500
    lb_protocol       = "http"
  }

  security_groups = [aws_security_group.client_lb.id]
}