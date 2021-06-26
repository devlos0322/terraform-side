# terraform-side

테라폼 작동 테스트

Offical document : Terraform | HashiCorp
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources

## 1. Terraform 기본 명령어
init : provider.tf를 사용, 테라폼 명령어 사용을 위한 각종 설정 진행, .terraform 파일 상성

plan : 테라폼 코드 시뮬레이션. 하지만 실제 인프라 환경정보와 동기화 되지는 않음

apply : 테라폼 코드로 실제 인프라를 생성. plan과 같이 시뮬레이션 우선 실행 후, yes 입력시 생성됨

## 2. cases
### 2.1. case1 provider, s3 생성

Step 1) 생성

provider.tf
```terraform
provider "aws" {
    region = "ap-northeast-2"
    version = "~>3.0"
}
```

s3.tf
```terraform
resource "aws_s3_bucket" "case_1_bucket_devlos" {
    bucket = "case-1-bucket-devlos"

    tags = {
        Name = "devlos bucket"
        Environment = "Dev"
    }
}
```
Step 2) 실행
```sh
terraform init
terraform plan
terraform apply
terraform destroy
```

### 2.2. case2 provider, vpc, subnet * 3 생성

Step 1) 생성

provider.tf
```terraform
provider "aws" {
    region = "ap-northeast-2"
    version = "~>3.0"
}
```
vpc.tf
```terraform
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
```

Step 2) 실행

```sh
terraform init
terraform plan
terraform apply
terraform destroy
```