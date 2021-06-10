output "Public-Ip" {
  value = aws_instance.EC2.public_ip
}

output "Private-IP" {
  value = aws_instance.EC2.private_ip
}
