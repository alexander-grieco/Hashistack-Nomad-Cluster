output "vpc_id" {
  value = aws_vpc.hashistack.id
}

output "subnet_ids" {
  value = values(aws_subnet.public_subnet)[*].id
}

output "route_table_association_id" {
  value = values(aws_route_table_association.public_subnet)[*].id
}