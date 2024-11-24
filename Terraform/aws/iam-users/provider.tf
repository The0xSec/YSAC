provider "aws" {
  region = "us-east-1"  # Specify your desired region
}

module "iam_users" {
  source     = "../../modules/iam_user-modules"
  user_count = 5
}
