resource "aws_instance" "wordpress_server" {
  ami           = var.ami_id
  instance_type = "t3.small"
  key_name      = var.key_name

  subnet_id                   = aws_subnet.wordpress_subnet.id
  vpc_security_group_ids      = [aws_security_group.wordpress_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 20
  }

  user_data = templatefile("${path.module}/scripts/install-wordpress.sh", {
  })

  tags = {
    Name = "wordpress-server"
  }
}