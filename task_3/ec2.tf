resource "aws_instance" "control_plane_ec2" {
  ami           = data.aws_ami.ubuntu22.id
  instance_type = "t3.small"

  vpc_security_group_ids = [aws_security_group.host_sg.id]

  subnet_id = aws_subnet.private_subnets[var.private_subnets[0].cidr_block].id
  key_name  = "main"

  tags = {
    Name = "control_plane_ec2"
  }
}

resource "aws_instance" "worker_ec2" {
  count = 1

  ami           = data.aws_ami.ubuntu22.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.host_sg.id]

  subnet_id = aws_subnet.private_subnets[var.private_subnets[0].cidr_block].id
  key_name  = "main"

  tags = {
    Name = "worker_ec2_${count.index}"
  }
}