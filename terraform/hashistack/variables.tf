variable "owner_name" {}
variable "owner_email" {}
variable "region" {}
variable "key_pair" {}

variable "ami" {
  default = null
}

variable "stack_name" {
  default = "hashistack"
}
