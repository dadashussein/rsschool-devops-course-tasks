output "public_ip" {
  value = aws_instance.k3s_server.public_ip
}

output "k3s_connection_command" {
  value = "ssh ubuntu@${aws_instance.k3s_server.public_ip}"
}