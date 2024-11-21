# Key Pair
resource "aws_key_pair" "k3s_key" {
  key_name   = "k3s-key"
  public_key = var.ssh_public_key
}

# EC2 Instance
resource "aws_instance" "k3s_server" {
  ami           = "ami-0ec7f9846da6b0f61"
  instance_type = "t3.small"

  iam_instance_profile = aws_iam_instance_profile.ec2_ecr_profile.name
  subnet_id                   = aws_subnet.k3s_subnet.id
  vpc_security_group_ids      = [aws_security_group.k3s_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.k3s_key.key_name

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