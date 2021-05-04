resource "aws_vpc" "hashistack" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.name_tag_prefix} VPC"
  }
}

# Create an Internet Gateway for the VPC.
resource "aws_internet_gateway" "hashistack" {
  vpc_id = aws_vpc.hashistack.id

  tags = {
    Name = "${var.name_tag_prefix} IGW"
  }
}

# Create a public subnet.
resource "aws_subnet" "public_subnet" {
  for_each = { for idx, cidr in var.subnet_cidrs : idx => cidr }

  vpc_id                  = aws_vpc.hashistack.id
  cidr_block              = each.value
  availability_zone       = var.subnet_azs[each.key]
  map_public_ip_on_launch = true

  tags = {
    Name = "${each.value} - ${var.name_tag_prefix}"
  }
}

# Create a route table allowing all addresses access to the IGW.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.hashistack.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hashistack.id
  }

  tags = {
    Name = "${var.name_tag_prefix} Public Route Table"
  }
}

# Now associate the route table with the public subnet
# giving all public subnet instances access to the internet.
resource "aws_route_table_association" "public_subnet" {
  for_each = aws_subnet.public_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}