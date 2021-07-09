output "vpc_id" {
  value = aws_vpc.hashistack.id
}

output "subnet_ids" {
  value = values(aws_subnet.public_subnet)[*].id
}
