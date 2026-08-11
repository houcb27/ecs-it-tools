output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "ID of the Public Subnet"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "ID of the Private VPC"
  value       = aws_subnet.private[*].id
}