resource "aws_security_group" "server_lb" {
  name   = "nomad-server-lb"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  # Nomad HTTP API & UI.
  ingress {
    from_port   = 4646
    to_port     = 4646
    protocol    = "tcp"
    cidr_blocks = var.allowlist_ip
  }

  # Consul HTTP API & UI.
  ingress {
    from_port   = 8501
    to_port     = 8501
    protocol    = "tcp"
    cidr_blocks = var.allowlist_ip
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "client_lb" {
  name   = "nomad-client-lb"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  # Consul HTTP API & UI.
  ingress {
    from_port   = 8501
    to_port     = 8501
    protocol    = "tcp"
    cidr_blocks = var.allowlist_ip
  }

  # Webapp HTTP.
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowlist_ip
  }

  # Grafana metrics dashboard.
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = var.allowlist_ip
  }

  # Prometheus dashboard.
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = var.allowlist_ip
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "primary" {
  name   = "${var.stack_name}-lb"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowlist_ip
  }

  # Nomad
  ingress {
    from_port       = 4646
    to_port         = 4646
    protocol        = "tcp"
    cidr_blocks     = var.allowlist_ip
    security_groups = [aws_security_group.server_lb.id]
  }

  ingress {
    from_port       = 4647
    to_port         = 4647
    protocol        = "tcp"
    cidr_blocks     = var.allowlist_ip
    security_groups = [aws_security_group.server_lb.id]
  }

  ingress {
    from_port       = 4647
    to_port         = 4648
    protocol        = "tcp"
    cidr_blocks     = var.allowlist_ip
    security_groups = [aws_security_group.server_lb.id]
  }

  ingress {
    from_port       = 4648
    to_port         = 4648
    protocol        = "udp"
    cidr_blocks     = var.allowlist_ip
    security_groups = [aws_security_group.server_lb.id]
  }

  # Consul
  ingress {
    from_port       = 8500
    to_port         = 8500
    protocol        = "tcp"
    cidr_blocks     = var.allowlist_ip
    security_groups = [aws_security_group.server_lb.id]
  }

  ingress {
    from_port       = 8501
    to_port         = 8501
    protocol        = "tcp"
    cidr_blocks     = var.allowlist_ip
    security_groups = [aws_security_group.server_lb.id]
  }

  ingress {
    from_port       = 8400
    to_port         = 8400
    protocol        = "tcp"
    cidr_blocks     = var.allowlist_ip
    security_groups = [aws_security_group.server_lb.id]
  }

  ingress {
    from_port       = 8301
    to_port         = 8301
    protocol        = "tcp"
    cidr_blocks     = var.allowlist_ip
    security_groups = [aws_security_group.server_lb.id]
  }

  ingress {
    from_port       = 8301
    to_port         = 8302
    protocol        = "tcp"
    cidr_blocks     = var.allowlist_ip
    security_groups = [aws_security_group.server_lb.id]
  }

  ingress {
    from_port       = 8301
    to_port         = 8302
    protocol        = "udp"
    cidr_blocks     = var.allowlist_ip
    security_groups = [aws_security_group.server_lb.id]
  }

  ingress {
    from_port       = 8302
    to_port         = 8302
    protocol        = "tcp"
    cidr_blocks     = var.allowlist_ip
    security_groups = [aws_security_group.server_lb.id]
  }

  ingress {
    from_port       = 8300
    to_port         = 8300
    protocol        = "tcp"
    cidr_blocks     = var.allowlist_ip
    security_groups = [aws_security_group.server_lb.id]
  }

  # Fabio 
  ingress {
    from_port   = 9998
    to_port     = 9998
    protocol    = "tcp"
    cidr_blocks = var.allowlist_ip
  }

  ingress {
    from_port   = 9999
    to_port     = 9999
    protocol    = "tcp"
    cidr_blocks = var.allowlist_ip
  }

  # grafana
  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.client_lb.id]
  }
  ingress {
    from_port       = 8081
    to_port         = 8081
    protocol        = "tcp"
    security_groups = [aws_security_group.client_lb.id]
  }

  ingress {
    from_port       = 9090
    to_port         = 9090
    protocol        = "tcp"
    security_groups = [aws_security_group.client_lb.id]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.client_lb.id]
  }

  # Nomad dynamic port allocation range.
  ingress {
    from_port       = 20000
    to_port         = 32000
    protocol        = "tcp"
    security_groups = [aws_security_group.client_lb.id]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}