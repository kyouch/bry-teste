terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.43.0"
    }
    ansible = {
      source  = "ansible/ansible"
      version = "~> 1.2.0"
    }
  }

  backend "s3" {
    bucket = "bry-teste-bucket"
    key    = "terraform.tfstate"
  }
}

provider "aws" {
}
