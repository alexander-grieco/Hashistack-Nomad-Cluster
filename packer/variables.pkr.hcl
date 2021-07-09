variable "consul_version" {
  type    = string
  default = "1.9.7"
}

variable "nomad_version" {
  type    = string
  default = "1.1.2"
}

variable "tags" {
  type = map(string)
  default = {
    "name" = "Nomad"
    "type" = "Hashistack"
  }
}