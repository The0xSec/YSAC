provider "random" {}

variable "user_count" {
  description = "Number of users to create"
  type        = number
  default     = 2
}

resource "random_pet" "user_names" {
  count  = var.user_count
  length = 2
}

resource "aws_iam_user" "user" {
  count = var.user_count

  name = random_pet.user_names[count.index].id
}

resource "aws_iam_group" "developer" {
  name = "Developer"
}

resource "aws_iam_group_membership" "developer_membership" {
  name  = "developer-membership"
  group = aws_iam_group.developer.name

  users = [
    aws_iam_user.user[0].name,
    aws_iam_user.user[1].name
  ]
}

resource "aws_iam_group" "operators" {
  name = "Operators"
}

resource "aws_iam_group_membership" "operators_membership" {
  name  = "operators-membership"
  group = aws_iam_group.operators.name

  users = aws_iam_user.user[*].name
}

resource "aws_iam_policy" "vpc_management" {
  name        = "VPCManagementPolicy"
  description = "Policy to manage a specific VPC"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeVpcs",
          "ec2:ModifyVpcAttribute",
          "ec2:DescribeSubnets",
          "ec2:CreateSubnet",
          "ec2:DeleteSubnet",
          "ec2:DescribeRouteTables",
          "ec2:CreateRouteTable",
          "ec2:DeleteRouteTable",
          "ec2:AssociateRouteTable",
          "ec2:DisassociateRouteTable",
          "ec2:CreateRoute",
          "ec2:DeleteRoute"
        ],
        Resource = [
          "arn:aws:ec2:*:*:vpc/vpc-12345678",
          "arn:aws:ec2:*:*:subnet/*",
          "arn:aws:ec2:*:*:route-table/*"
        ],
        Condition = {
          StringEquals = {
            "ec2:vpc" = "vpc-12345678"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "developer_lambda_access" {
  name       = "developer-lambda-access"
  groups     = [aws_iam_group.developer.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

resource "aws_iam_policy_attachment" "operators_vpc_management" {
  name       = "operators-vpc-management"
  groups     = [aws_iam_group.operators.name]
  policy_arn = aws_iam_policy.vpc_management.arn
}

output "user_names" {
  value = random_pet.user_names[*].id
}

output "developer_group_users" {
  value = aws_iam_group_membership.developer_membership.users
}

output "operators_group_users" {
  value = aws_iam_group_membership.operators_membership.users
}
