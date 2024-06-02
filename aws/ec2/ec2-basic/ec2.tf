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

  root_block_device {
    delete_on_termination = true
  }

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
