build {
    sources = [
        "source.amazon-ebs.aws-ubuntu"
    ]

    provisioner "shell" {
        script = "scripts/install-nomad.sh"
    }

    provisioner "file" {
        source = "files/nomad.service"
        destination = "/etc/systemd/system/"
    }

    provisioner "file" {
        source = "files/nomad.hcl"
        destination = "/etc/nomad.d/"
    }

    provisioner "file" {
        source = "files/client.hcl"
        destination = "/etc/nomad.d/"
    }

    provisioner "shell" {
        script = "scripts/start-client.sh"
    }
}