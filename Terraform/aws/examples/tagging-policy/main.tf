terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
}

resource "aws_organizations_policy" "iac-tagging-policy" {
  name    = "IAC-Tagging-Policy"
  content = file("../../policy-library/tagging-enforcement/iac-tag.json")
  type    = "TAG_POLICY"
}