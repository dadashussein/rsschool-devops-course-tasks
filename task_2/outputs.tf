output "eip" {
  value = aws_eip.public_ip.public_ip
}

output "security_group_arn" {
  value = aws_security_group.nat_sg.arn
}

output "security_group_id" {
  value = aws_security_group.nat_sg.id
}

output "network_interface_id" {
  value = aws_network_interface.nat_interface.id
}

output "nat_instance_public_ip_address" {
  value = aws_instance.nat_instance.public_ip
}

output "nat_instance_private_ip_address" {
  value = aws_instance.nat_instance.private_ip
}

output "test_ec2_public_ip_address" {
  value = aws_instance.test_ec2.public_ip
}

output "test_ec2_private_ip_address" {
  value = aws_instance.test_ec2.private_ip
}

output "nat_security_group_arn" {
  value = aws_security_group.nat_sg.arn
}

output "k3s_server_security_group_arn" {
  value = aws_security_group.k3s_server_sg.arn
}

output "k3s_agent_security_group_arn" {
  value = aws_security_group.k3s_agent_sg.arn
}

output "k3s_server_public_ip_address" {
  value = aws_instance.k3s_server.public_ip
}

output "k3s_server_private_ip_address" {
  value = aws_instance.k3s_server.private_ip
}

output "k3s_agent_public_ip_address" {
  value = aws_instance.k3s_agent.public_ip
}

output "k3s_agent_private_ip_address" {
  value = aws_instance.k3s_agent.private_ip
}