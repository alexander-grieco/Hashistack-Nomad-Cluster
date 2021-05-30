job "fabio-nonssl" {
  datacenters = ["dc1"]
  type = "system"

  group "fabio-nonssl" {
    network {
      port "lb" {
        static = 9999
      }
      port "ui" {
        static = 9998
      }
    }
    task "fabio-nonssl" {
      driver = "docker"
      config {
        image = "fabiolb/fabio"
        network_mode = "host"
      }

      resources {
        cpu    = 100
        memory = 64
      }
    }
  }
}