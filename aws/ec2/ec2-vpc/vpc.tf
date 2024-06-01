resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-example"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "internet-gateway-example"
  }
}

resource "aws_route_table" "route_table_1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "route-table-example"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"

  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet-example"
  }
}

resource "aws_route_table_association" "route_table_association_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.route_table_1.id
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet-example-2"
  }
}

resource "aws_security_group" "security_group" {
  name = "security-group-example"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "security-group-example"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4 = "0.0.0.0/0"

  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

  tags = {
    Name = "allow-ssh" 
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.security_group.id

  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name = "allow-all"
  }
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  key_name = var.key_name

  subnet_id = aws_subnet.subnet_1.id

  associate_public_ip_address = true

  root_block_device {
    delete_on_termination = true
  }

  vpc_security_group_ids = [aws_security_group.security_group.id]

  tags = {
    Name = var.name_instance
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

output "conect_ssh" {
  value = "ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${aws_instance.web.public_ip}"
}
