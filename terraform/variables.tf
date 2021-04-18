variable "owner_name" {}
variable "owner_email" {}
variable "region" {}
variable "availability_zones" {}
variable "ami" {
  default = null
}
variable "key_name" {}

variable "stack_name" {
  default = "hashistack"
}