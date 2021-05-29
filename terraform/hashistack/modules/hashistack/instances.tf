data "aws_ami" "nomad_image" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["nomad-*"]
  }
}

resource "aws_instance" "nomad_server" {
  for_each               = { for idx, subnet_id in data.terraform_remote_state.network.outputs.subnet_ids : idx => subnet_id }
  ami                    = data.aws_ami.nomad_image.image_id
  instance_type          = var.server_instance_type
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.primary.id]
  subnet_id              = each.value

  tags = {
    Name           = "${var.stack_name}-server-${each.key + 1}"
    ConsulAutoJoin = "auto-join"
    OwnerName      = var.owner_name
    OwnerEmail     = var.owner_email
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.root_block_device_size
    delete_on_termination = "true"
  }

  user_data_base64     = base64gzip(data.template_file.user_data_server.rendered)
  iam_instance_profile = aws_iam_instance_profile.nomad_server.name
}