# Create the bastion host
resource "aws_instance" "bastion" {
  ami           = "ami-0e9377e5e340374c9"
  instance_type = "t2.micro"
  key_name      = "mygov"

  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id              = aws_subnet.bastion_subnet.id

  user_data = <<-EOF
              #!/bin/bash
              curl -sfL https://get.k3s.io | sh -
              EOF

  tags = {
    Name = "k3s-bastion"
  }
}
