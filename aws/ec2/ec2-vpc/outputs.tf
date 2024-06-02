output "public_ip" {
  value = aws_instance.server.public_ip
}

output "conect_ssh" {
  value = "ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${aws_instance.server.public_ip}"
}