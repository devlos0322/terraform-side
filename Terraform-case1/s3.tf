resource "aws_s3_bucket" "case_1_bucket_devlos" {
    bucket = "case-1-bucket-devlos"

    tags = {
        Name = "devlos bucket"
        Environment = "Dev"
    }
}