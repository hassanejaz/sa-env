terraform {
  required_version = ">= 0.12.10"
  backend "s3" {
    bucket = "agg-test-bucket"
    key    = "dev"
    region = "us-east-1"
  }
}
