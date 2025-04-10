resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.vpc_name}-${terraform.workspace}"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name        = "${var.vpc_name}-igw-${terraform.workspace}"
    Environment = var.environment
  }
}

resource "aws_eip" "nat_az1" {
  domain = "vpc"

  tags = {
    Name        = "eip-nat-az1-${terraform.workspace}"
    Environment = var.environment
  }
}

resource "aws_eip" "nat_az2" {
  domain = "vpc"

  tags = {
    Name        = "eip-nat-az2-${terraform.workspace}"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "this" {
  for_each = {
    priv_a = {
      eip       = aws_eip.nat_az1.id
      subnet_id = aws_subnet.public["pub_a"].id
    }
    priv_b = {
      eip       = aws_eip.nat_az2.id
      subnet_id = aws_subnet.public["pub_b"].id
    }
  }

  allocation_id = each.value.eip
  subnet_id     = each.value.subnet_id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name        = "nat-${each.key}-${terraform.workspace}"
    Environment = var.environment
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets[terraform.workspace]

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.vpc_name}-public-${each.key}-${terraform.workspace}"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets[terraform.workspace]

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name        = "${var.vpc_name}-private-${each.key}-${terraform.workspace}"
    Environment = var.environment
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.vpc_name}-public-rt-${terraform.workspace}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  for_each = var.private_subnets[terraform.workspace]

  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[each.key].id
  }

  tags = {
    Name        = "{var.vpc_name}-private-rt-${each.key}-${terraform.workspace}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}
