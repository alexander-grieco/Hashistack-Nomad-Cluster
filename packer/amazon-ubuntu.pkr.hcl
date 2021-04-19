source "amazon-ebs" "aws-ubuntu" {
  region        = "us-west-2"
  instance_type = "t2.micro"
  ami_name      = "nomad-hashistack"
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }

  tags = {
    Name = "Nomad"
    type = "Hashistack"
  }
  ssh_username          = "ubuntu"
  force_deregister      = true
  force_delete_snapshot = true
}
