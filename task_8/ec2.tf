# Key Pair

resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins-key"
  public_key = var.ssh-key
}

# EC2 Instance
resource "aws_instance" "k3s_server" {
  ami           = "ami-0e8d228ad90af673b"
  instance_type = "t2.small"

  subnet_id                   = aws_subnet.k3s_subnet.id
  vpc_security_group_ids      = [aws_security_group.k3s_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.jenkins_key.key_name

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  user_data = <<-EOF
              #!/bin/bash
              curl -sfL https://get.k3s.io | sh -
              EOF

  tags = {
    Name = "k3s-server"
  }
}
