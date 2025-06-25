resource "aws_vpc" "k8s_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "K8s VPC"
  }
}

resource "aws_subnet" "k8s_subnet" {
  vpc_id            = aws_vpc.k8s_vpc.id
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "k8s Subnet"
  }
}

resource "aws_internet_gateway" "k8s_ig" {
  vpc_id = aws_vpc.k8s_vpc.id

  tags = {
    Name = "k8s Internet Gateway"
  }
}

resource "aws_route_table" "k8s_rt" {
  vpc_id = aws_vpc.k8s_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s_ig.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id      = aws_subnet.k8s_subnet.id
  route_table_id = aws_route_table.k8s_rt.id
}