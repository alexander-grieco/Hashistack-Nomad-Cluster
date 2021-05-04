variable "owner_name" {}
variable "owner_email" {}
variable "region" {}
variable "availability_zones" {}
variable "encrypt_key" {}
variable "encrypt_key_consul" {}
variable "vpc_id" {}
variable "key_name" {}

variable "ami" {
  default = null
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "Subnet CIDRs"
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "stack_name" {
  default = "hashistack"
}
variable "cert_path" {
  type        = string
  default     = ""
  description = "File location to write cli certs"
}

variable "ssl_password" {
  type        = string
  default     = ""
  sensitive   = true
  description = "Password used to encrypt .pfx files that would be used in your browser for remote UI access"
}
