terraform {
  backend "s3" {
    profile        = "netpalm-public"
    region         = "ap-southeast-2"
    bucket         = "netpalm-public-tfstate"
    dynamodb_table = "netpalm-public-tfstate"
    encrypt        = true
    key            = "terraform.tfstate"
  }
}