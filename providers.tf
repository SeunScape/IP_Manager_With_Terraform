terraform {
  required_providers {
    awscc = {
      source = "hashicorp/awscc"
    }
  }
}

provider "awscc" {
  region = "us-east-1"
}
