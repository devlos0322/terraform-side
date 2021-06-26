resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "case_2_vpc_main"
    }
}

resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-northeast-2a"
    tags = {
        Name = "case_2_public_subnet_1"
    }
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "ap-northeast-2a"
    tags = {
        Name = "case_2_public_subnet_2"
    }
}

resource "aws_subnet" "public_subnet_3" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.20.0/24"
    availability_zone = "ap-northeast-2a"
    tags = {
        Name = "case_2_public_subnet_3"
    }
}