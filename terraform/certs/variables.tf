variable "tls_organization" {
  type        = string
  default     = "agrieco-nomad"
  description = "The organization name to use the TLS certificates."
}

variable "cert_path" {
  type        = string
  default     = ""
  sensitive   = true
  description = "File location to write cli certs"
}

variable "ssl_password" {
  type        = string
  default     = ""
  sensitive   = true
  description = "Password used to encrypt .pfx files that would be used in your browser for remote UI access"
}

variable "server_dns_prefix" {
  type    = string
  default = "admin"
}

variable "client_dns_prefix" {
  type    = string
  default = "www"
}

variable "hostname" {
  type = string
}