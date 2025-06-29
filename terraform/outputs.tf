output "ansible_server_public_ip" {
  value = aws_instance.ansible_server.public_ip
}

output "host1_public_ip" {
  value = aws_instance.host1.public_ip
}

output "host2_public_ip" {
  value = aws_instance.host2.public_ip
}
