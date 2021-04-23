data "aws_subnet_ids" "nomad" {
  vpc_id = data.aws_vpc.nomad.id
}

data "aws_ami" "nomad_image" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["nomad-*"]
  }
}

resource "aws_instance" "nomad_server" {
  for_each               = { for idx, subnet_id in distinct(data.aws_subnet_ids.nomad.ids) : subnet_id => idx }
  ami                    = data.aws_ami.nomad_image.image_id
  instance_type          = var.server_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.primary.id]
  subnet_id              = each.key

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

  user_data            = data.template_file.user_data_server[each.value].rendered
  iam_instance_profile = aws_iam_instance_profile.nomad_server.name
}