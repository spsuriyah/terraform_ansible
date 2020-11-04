availability_zone = "ap-south-1a"
vpc_name = "myvpc"
cidr_block = "10.1.0.0/16"
env = "test"

default_tags = {
  "Environment" = "test",
  "Terraform" = "true",
}

web_server_cidr_block = "10.1.1.0/24"

public_cidr_block = "10.1.0.0/24"


region = "ap-south-1" 

key_name = "mypem"

pem_path = "~/Downloads/mypem.pem"