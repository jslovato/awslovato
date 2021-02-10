provider aws = {
      source  = "hashicorp/aws"
      version = "~> 3.7"
      region  = var.region
    }
  }
}