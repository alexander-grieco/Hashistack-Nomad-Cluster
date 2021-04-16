data "aws_subnet_ids" "nomad" {
  vpc_id = data.aws_vpc.nomad.id
}

resource "aws_instance" "nomad_server" {
  for_each               = {for idx, subnet_id in distinct(data.aws_subnet_ids.nomad.ids): subnet_id => idx}
  ami                    = var.ami
  instance_type          = var.server_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.primary.id]

  tags = {
    Name           = "${var.stack_name}-server-${each.value + 1}"
    ConsulAutoJoin = "auto-join"
    OwnerName      = var.owner_name
    OwnerEmail     = var.owner_email
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.root_block_device_size
    delete_on_termination = "true"
  }

  user_data            = data.template_file.user_data_server.rendered
  iam_instance_profile = aws_iam_instance_profile.nomad_server.name
}