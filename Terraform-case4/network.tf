# vpc 설정
resource "aws_vpc" "case4_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "case4_vpc"
    }
}

# elastic IP 생성
resource "aws_eip" "case4_eip" {
    vpc = true
    lifecycle {
      create_before_destroy = true
    }
}

# public subnet 생성
resource "aws_subnet" "case4_subnet_public" {
    vpc_id = aws_vpc.case4_vpc.id
    availability_zone = "ap-northeast-2a"
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "case4_subnet_public"
    }
}

# private subnet 생성
resource "aws_subnet" "case4_subnet_private" {
    vpc_id = aws_vpc.case4_vpc.id
    availability_zone = "ap-northeast-2a"
    cidr_block = "10.0.10.0/24"
    tags = {
        Name = "case4_subnet_private"
    }
}


# IGW 생성
resource "aws_internet_gateway" "case4_igw" {
    vpc_id = aws_vpc.case4_vpc.id
    tags = {
        Name = "case4_igw"
    }
}

# NAT GW 생성
resource "aws_nat_gateway" "case4_nat_gw" {
    allocation_id = aws_eip.case4_eip.id
    subnet_id = aws_subnet.case4_subnet_public.id
    tags = {
        Name = "case4_nat_gw"
    }
}

# public route table 생성
resource "aws_route_table" "case4_route_public" {
    vpc_id = aws_vpc.case4_vpc.id
    tags = {
        Name = "case4_route_public"
    }
}

# public route table 관계 생성
resource "aws_route_table_association" "case4_route_public_association" {
    subnet_id = aws_subnet.case4_subnet_public.id
    route_table_id = aws_route_table.case4_route_public.id
}

resource "aws_route" "case4_route_public" {
    route_table_id = aws_route_table.case4_route_public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.case4_igw.id
}

# private route table 생성
resource "aws_route_table" "case4_route_private" {
    vpc_id = aws_vpc.case4_vpc.id
    tags = {
        Name = "case4_route_private"
    }
}

resource "aws_route_table_association" "case4_route_private_association" {
    subnet_id = aws_subnet.case4_subnet_private.id
    route_table_id = aws_route_table.case4_route_private.id
}

resource "aws_route" "case4_private_nat" {
    route_table_id = aws_route_table.case4_route_private.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.case4_nat_gw.id
}