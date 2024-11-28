# Output variables
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = aws_subnet.subnets[*].id
}

output "availability_zones" {
  description = "Availability zones for the subnets"
  value       = aws_subnet.subnets[*].availability_zone
}