datacenter = "dc1"
bind_addr = "0.0.0.0"
data_dir = "/opt/nomad/data"
log_level = "DEBUG"

client {
  enabled = true
  node_class = NODE_CLASS

  options {
    "driver.raw_exec.enable"    = "1"
    "docker.privileged.enabled" = "true"
    "driver.docker.enable"      = "1"
    "driver.whitelist"          = "docker"
    "user.blacklist"            = "root,ubuntu"
  }
}

telemetry {
  collection_interval = "1s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}
