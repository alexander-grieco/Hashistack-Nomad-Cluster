variable "consul_acl_token" {
  type    = string
  default = ""
}

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
      mode = "host"
    }
    task "fabio" {

      driver = "docker"
      config {
        image = "fabiolb/fabio"
        args = [
          "-registry.consul.token=${var.consul_acl_token}",
          "-registry.consul.addr=https://127.0.0.1:8501",
          "-registry.consul.tls.keyfile=local/consul-client-key.pem",
          "-registry.consul.tls.certfile=local/consul-client-cert.pem",
          "-registry.consul.tls.capath=local/consul-ca.pem"
        ]
        ports = ["lb", "ui"]
      }
      // "-registry.consul.token=${var.consul_acl_token}",
      // "-proxy.cs=cs=consul;type=file;cert=/etc/consul.d/client.pem;key=/etc/consul.d/client-key.pem;clientca=/etc/consul.d/consul-ca.pem;refresh=3s", 
          // "-proxy.addr=:443;cs=consul"
      // "-registry.consul.tls.keyfile=/Users/alexgrieco/certs/consul/cli-key.pem",
      // "-registry.consul.tls.certfile=/Users/alexgrieco/certs/consul/cli.pem",
      // "-registry.consul.tls.cafile=/Users/alexgrieco/certs/consul/consul-ca.pem",
      // "-registry.consul.tls.insecureskipverify=false"
      resources {
        cpu    = 100
        memory = 64
      }
    

      template {
        change_mode = "noop"
        destination = "local/consul-ca.pem"
        data        = file("/Users/alexgrieco/certs/consul/consul-ca.pem")
      }

      template {
        change_mode = "noop"
        destination = "local/consul-client-cert.pem"
        data        = file("/Users/alexgrieco/certs/consul/cli.pem")
      }

      template {
        change_mode = "noop"
        destination = "local/consul-client-key.pem"
        data        = file("/Users/alexgrieco/certs/consul/cli-key.pem")
      }
    }
  }
}