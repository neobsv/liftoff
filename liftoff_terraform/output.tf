# output the vpc id
output "vpc_id" {
  value       = aws_vpc.vpc0.id
  description = "The ID of the created VPC"
}

# output the id of the private subnet
output "subnet_ids" {
  value       = aws_subnet.private.id
  description = "The IDs of the created private subnets"
}

# Output the public ip address of the jump host
output "jump_host_public_ip" {
  value       = aws_instance.jump_host.public_ip
  description = "The public IP address of the created jump host"
}
