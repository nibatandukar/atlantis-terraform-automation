
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
//provider "aws" {
//region = "ap-south-1"
//}
        


