build {
  sources = [
    "source.amazon-ebs.aws-ubuntu"
  ]

  provisioner "shell" {
    inline = [
      "/usr/bin/cloud-init status --wait",
      "sudo mkdir /ops",
      "sudo chmod 777 /ops"
    ]
  }

  provisioner "file" {
    source      = "files"
    destination = "/ops"
  }

  provisioner "file" {
    source      = "scripts"
    destination = "/ops"
  }

  provisioner "shell" {
    script = "scripts/initialize.sh"
    environment_vars = [
      "CONSULVERSION=${var.consul_version}",
      "NOMADVERSION=${var.nomad_version}"
    ]
  }
}
