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
provider.tf
```terraform
provider "aws" {
    region = "ap-northeast-2"
    version = "~>3.0"
}
```

