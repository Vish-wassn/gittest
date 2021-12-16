
provider "aws" {
  region = var.aws_region
}

#Create security group with firewall rules
resource "aws_security_group" "security_terra" {
  name        = var.my_vpc_secure
vpc_id      ="${aws_vpc.my_vpc.id}"
description = "security group for terra"

ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.my_vpc_secure
  }
}

resource "aws_instance" "myFirstInstance" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
subnet_id="${aws_subnet.p_subnet1.id}"
  associate_public_ip_address = true
  vpc_security_group_ids=["${aws_security_group.security_terra.id}"]

  tags= {
    Name = var.tag_name
  }
}

resource "aws_vpc" "my_vpc" {
  cidr_block       = var.my_vpc1
  instance_tenancy = "default"

  tags = {
    Name = "terra_vpc"
  }
}

resource "aws_subnet" "p_subnet1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.p_subnet12
#for public it should be false

# map_public_ip_on_lunch ="true"
  availability_zone= "ap-south-1a"

  tags = {
    Name = "public_subnet1"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id       = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.i-gw.id
  }
  tags       = {
    Name     = "p_Route Table"
  }
}


# Associate Public Subnet 1 to "Public Route Table"
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id           = aws_subnet.p_subnet1.id
  route_table_id      = aws_route_table.public-route-table.id
}

resource "aws_internet_gateway" "i-gw" {
 vpc_id = aws_vpc.my_vpc.id
 # connectivity_type = "public"

  tags = {
    Name = "terra_igw"
  }
}
    