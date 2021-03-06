resource "aws_elb_attachment" "nomad_server" {
  count = var.server_count

  elb      = aws_elb.nomad_server.id
  instance = aws_instance.nomad_server[count.index].id
}

resource "aws_elb" "nomad_server" {
  name         = "${var.stack_name}-nomad-server"
  subnets      = data.terraform_remote_state.network.outputs.subnet_ids
  internal     = false
  idle_timeout = 360

  listener {
    instance_port     = 4646
    instance_protocol = var.nomad_ssl == true ? "tcp" : "http"
    lb_port           = 4646
    lb_protocol       = var.nomad_ssl == true ? "tcp" : "http"
  }

  listener {
    instance_port     = var.consul_ssl == true ? 8501 : 8500
    instance_protocol = var.consul_ssl == true ? "tcp" : "http"
    lb_port           = var.consul_ssl == true ? 8501 : 8500
    lb_protocol       = var.consul_ssl == true ? "tcp" : "http"
  }
  security_groups = [aws_security_group.server_lb.id]
}

resource "aws_elb" "nomad_client" {
  name     = "${var.stack_name}-nomad-client"
  subnets  = data.terraform_remote_state.network.outputs.subnet_ids
  internal = false
  listener {
    instance_port     = var.consul_ssl == true ? 8501 : 8500
    instance_protocol = var.consul_ssl == true ? "tcp" : "http"
    lb_port           = var.consul_ssl == true ? 8501 : 8500
    lb_protocol       = var.consul_ssl == true ? "tcp" : "http"
  }
  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 9090
    instance_protocol = "tcp"
    lb_port           = 9090
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 3000
    instance_protocol = "tcp"
    lb_port           = 3000
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 8081
    instance_protocol = "tcp"
    lb_port           = 8081
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 9998
    instance_protocol = "tcp"
    lb_port           = 9998
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 9999
    instance_protocol = "tcp"
    lb_port           = 9999
    lb_protocol       = "tcp"
  }

  // health_check {
  //   healthy_threshold   = 8
  //   unhealthy_threshold = 2
  //   timeout             = 3
  //   target              = "TCP:8081"
  //   interval            = 30
  // }

  security_groups = [aws_security_group.client_lb.id]
}