job "fabio" {
  datacenters = ["dc1"]
  type = "system"

  group "fabio" {
    network {
      port "lb" {
        static = 9999
      }
      port "ui" {
        static = 9998
      }
    }
    task "fabio" {
      driver = "docker"
      config {
        image = "fabiolb/fabio"
        network_mode = "host"
        ports = ["lb","ui"]
        args = [
          "-registry.consul.addr=localhost:8501",
          "-registry.consul.token=6b4a5cdb-8e86-d823-d050-a7e8825abe2f",
        ]
      }

      resources {
        cpu    = 200
        memory = 128
      }
    }
  }
}