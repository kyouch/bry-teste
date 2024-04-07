data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_hostnames = true

  tags = {
    Name = "${var.kubernetes_name}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.cidr_public_subnet)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr_public_subnet[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.kubernetes_name}-pubsubnet"
    "kubernetes.io/cluster/${var.kubernetes_name}" = "owned"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.kubernetes_name}-igw"
  }
}


resource "aws_route_table" "route_talbe" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.kubernetes_name}-rt"
  }
}

resource "aws_route_table_association" "rta_public_subnet" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.route_talbe.id
}
