# terraform-side

테라폼 작동 테스트

Offical document : Terraform | HashiCorp
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources

## 1. Terraform 기본 명령어
init : provider.tf를 사용, 테라폼 명령어 사용을 위한 각종 설정 진행, .terraform 파일 상성

plan : 테라폼 코드 시뮬레이션. 하지만 실제 인프라 환경정보와 동기화 되지는 않음

apply : 테라폼 코드로 실제 인프라를 생성. plan과 같이 시뮬레이션 우선 실행 후, yes 입력시 생성됨

## 2. 배경지식

### 2.1. VPC 핵심 구성요소
* Subnet: VPC의 IP 주소 범위
* Routing Table: 네트워크 트래픽을 전달할 위치를 결정하는데 사용되는 라우팅이라는 규칙의 집합
* IGW(Internet Gateway): VPC와 리소스간 통신을 활성화 하기위한 Gateway
* NAT GATEWAY: 네트워크 주소 변환을 통해 프라이빗 서브넷에서 인터넷 또는 기타 AWS 서비스에 연결이 가능한 Gateway
* Security Group: 가상 방화벽, 포트 관리
* VPC Endpoint: PrivateLink 구동 지원(?). AWS 서비스 및 VPC 엔드포인트 서비스에 VPC를 비공개로 연결. 서비스간 다이렉트 연결
### 2.2. VPC 할당 가능 대역
네트워크 사설망 대역: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
## 3. cases
### 3.1. case1 provider, s3 생성

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

### 3.2. case2 provider, vpc, subnet * 3 생성
하나의 VPC내에 subnet 3개 생성. cidr_blocke을 10.0.0.0/24로 설정하여 하나의 서브넷에 할당 가능한 IP 대역을 251개 생성 (2^(32-24), 예약 IP: 5)

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

### 3.3. case2 provider, vpc, subnet * 3 생성
하나의 VPC내에 subnet 3개 생성. cidr_blocke을 10.0.0.0/26로 설정하여 하나의 서브넷에 할당 가능한 IP 대역을 59개 생성 (2^(32-26), 예약 IP: 5)

Step 1) 생성

provider.tf
```terraform
provider "aws" {
    region = "ap-northeast-2"
}
```

vpc.tf
```terraform
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
```

Step 2) 실행
```sh
terraform init
terraform plan
terraform apply
terraform destroy
```