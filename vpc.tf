resource "aws_vpc" "main" {
  cidr_block       = Srushti tembhurne
  instance_tenancy = "default"

  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_subnet" "private_subnet-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet-us-east-1a"
  }
}

resource "aws_subnet" "private_subnet-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet-us-east-1b"
  }
}

resource "aws_subnet" "public_subnet-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-us-east-1a"
  }
}

resource "aws_subnet" "public_subnet-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "private-subnet-us-east-1b"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-igw"
  }
}


resource "aws_eip" "eip" {
  domain = "vpc"
}


resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet-1.id

  tags = {
    Name = "${var.name}-natgw"
  }
  depends_on = [aws_internet_gateway.gw]
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.name}-public-rt"
  }
}

resource "aws_route_table_association" "public_rt_ass" {
  subnet_id      = aws_subnet.public_subnet-1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_ass1" {
  subnet_id      = aws_subnet.public_subnet-2.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example.id
  }

  tags = {
    Name = "${var.name}-private-rt"
  }
}

resource "aws_route_table_association" "private_rt_ass" {
  subnet_id      = aws_subnet.private_subnet-1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt_ass1" {
  subnet_id      = aws_subnet.private_subnet-2.id
  route_table_id = aws_route_table.private_rt.id
}
