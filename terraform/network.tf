# ==========================================
# NexaVault Custom VPC
# ==========================================

resource "aws_vpc" "nexavault_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "NexaVault-Custom-VPC"
  }
}


# ==========================================
# Available Availability Zones
# ==========================================

data "aws_availability_zones" "available" {
  state = "available"
}


# ==========================================
# Public Subnet
# ==========================================

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.nexavault_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "NexaVault-Public-Subnet"
  }
}


# ==========================================
# Internet Gateway
# ==========================================

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nexavault_vpc.id

  tags = {
    Name = "NexaVault-Internet-Gateway"
  }
}


# ==========================================
# Public Route Table
# ==========================================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.nexavault_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "NexaVault-Public-Route-Table"
  }
}


# ==========================================
# Public Subnet Route Association
# ==========================================

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

