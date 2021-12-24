output "vpc_id" {
  value = aws_vpc.hashistack.id
}

output "subnet_ids" {
  value = values(aws_subnet.public_subnet)[*].id
}

// output "hosted_zone_name" {
//   value = aws_route53_zone.hosted_zone.name
// }

// output "hosted_zone_id" {
//   value = aws_route53_zone.hosted_zone.zone_id
// }