
## Configuration

The application uses a configuration file located in the `libs/iam/config.json` directory. This file allows you to specify the number of users, group names, and policy documents. Below is a sample configuration:

```json
iam:
  user_count: 5  # Number of IAM users to create
  developer_group: "Developers"  # Name of the developer group
  operators_group: "Operators"  # Name of the operators group

vpc_policy:
  description: "Policy to manage a specific VPC"  # Description of the VPC policy
  document: |
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
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
          "Resource": [
            "arn:aws:ec2:*:*:vpc/vpc-12345678",
            "arn:aws:ec2:*:*:subnet/*",
            "arn:aws:ec2:*:*:route-table/*"
          ],
          "Condition": {
            "StringEquals": {
              "ec2:vpc": "vpc-12345678"
            }
          }
        }
      ]
    }
