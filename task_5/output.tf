output "wordpress_public_ip" {
  value = aws_instance.wordpress_server.public_ip
}