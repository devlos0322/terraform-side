resource "aws_vpc" "case3_main"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "case3_main"
    }
}

resource "aws_subnet" "case3_subnet_1" {
    vpc_id = aws_vpc.case3_main.id
    cidr_block = "10.0.0.0/26"
    availability_zone = "ap-northeast-2a"
    tags = {
        Name = "case3_subnet_1"
    }
}

resource "aws_subnet" "case3_subnet_2" {
    vpc_id = aws_vpc.case3_main.id
    cidr_block = "10.0.10.0/26"
    availability_zone = "ap-northeast-2a"
    tags = {
        Name = "case3_subnet_2"
    }
}

resource "aws_subnet" "case3_subnet_3" {
    vpc_id = aws_vpc.case3_main.id
    cidr_block = "10.0.20.0/26"
    availability_zone = "ap-northeast-2a"
    tags = {
        Name = "case3_subnet_3"
    }
}
