terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "remote" {
    organization = "awslovato"

    workspaces {
      name = "tf-awslovato"
    }
  }
}