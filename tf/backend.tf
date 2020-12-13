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

terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "3.18.0"
    }
  }
}

provider "aws" {
  # region = "us-east-1"
  region = "ap-southeast-2"
  profile = "netpalm-public"
}