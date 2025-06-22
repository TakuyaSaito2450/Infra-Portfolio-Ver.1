#####
#VPC#
#####
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/27"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support =  true
}

########
#Subnet#
########
resource "aws_subnet" "public_subnet_1a" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = true
  cidr_block        = "10.0.0.0/27"

}

########
#Route Table#
########
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "public_rt_1a" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet_1a.id
}

########
#Internet Gateway#
########
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "public_rt_igw_r" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}