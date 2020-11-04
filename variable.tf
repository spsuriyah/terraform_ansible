variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "vpc_name" {}
variable "cidr_block" {}
variable default_tags {}
variable web_server_cidr_block {}
variable availability_zone{}
variable key_name {}
variable pem_path {}
variable public_cidr_block {}
variable env {}
variable all_ip {
  default = "0.0.0.0/0"
}
