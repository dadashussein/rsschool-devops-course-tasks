resource "aws_instance" "bastion_ec2" {
  ami                    = data.aws_ami.ubuntu22.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  subnet_id = aws_subnet.public_subnets[var.public_subnets[0].cidr_block].id
  key_name  = "main"

  tags = {
    Name = "bastion_ec2"
  }
}