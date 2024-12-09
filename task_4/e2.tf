resource "aws_instance" "jenkins_server" {
  ami           = var.ami_id
  instance_type = "t3.small"
  key_name      = var.key_name

  subnet_id                   = aws_subnet.jenkins_subnet.id
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 20
  }

  user_data = templatefile("${path.module}/scripts/install-jenkins.sh", {
    jenkins_admin_password = var.jenkins_admin_password
  })

  tags = {
    Name = "jenkins-server"
  }
}