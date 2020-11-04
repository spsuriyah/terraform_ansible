resource "aws_instance" "web_server" {
  ami = "ami-0e306788ff2473ccb"
  instance_type = "t2.micro"
  key_name = var.key_name
  subnet_id = aws_subnet.public.id
  associate_public_ip_address = true      
  vpc_security_group_ids = [aws_security_group.web_server_group.id]
  tags = merge(var.default_tags, map(
    "Name", "web_server",
    "AnsibleHostName", "web_server"
  ))
  volume_tags = merge(var.default_tags, map(
    "Name", "web_server"
  ))
  root_block_device {
      volume_size = "10"
      volume_type = "gp2"
    }
  provisioner "local-exec" {
  command = "sleep 120; ansible-playbook -i '${aws_instance.web_server.public_ip}', ansible_playbook.yml"
  }
}


resource "aws_eip" "instance_eip" {
  instance = aws_instance.web_server.id
  vpc      = true
}

resource "aws_security_group" "web_server_group" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.default_tags, map(
    "Name", "web_server_group"
  ))
}

resource "aws_security_group_rule" "web_server_ingress_ssh" {
  from_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.web_server_group.id
  to_port = 22
  type = "ingress"
  cidr_blocks = [var.all_ip]
}

resource "aws_security_group_rule" "web_server_egress_http" {
  from_port = 80
  protocol = "tcp"
  security_group_id = aws_security_group.web_server_group.id
  to_port = 80
  type = "egress"
  cidr_blocks = [var.all_ip]
}

resource "aws_security_group_rule" "web_server_egress_https" {
  from_port = 443
  protocol = "tcp"
  security_group_id = aws_security_group.web_server_group.id
  to_port = 443
  type = "egress"
  cidr_blocks = [var.all_ip]
}

