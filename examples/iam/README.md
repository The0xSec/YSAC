<p><a target="_blank" href="https://app.eraser.io/workspace/Tms7ttzQgceZPstdgsaB" id="edit-in-eraser-github-link"><img alt="Edit in Eraser" src="https://firebasestorage.googleapis.com/v0/b/second-petal-295822.appspot.com/o/images%2Fgithub%2FOpen%20in%20Eraser.svg?alt=media&amp;token=968381c8-a7e7-472a-8ed6-4a6626da5501"></a></p>

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
```



<!-- eraser-additional-content -->
## Diagrams
<!-- eraser-additional-files -->
<a href="/examples/iam/README-cloud-architecture-1.eraserdiagram" data-element-id="An__4sVAZ0ekUnIb2quuB"><img src="/.eraser/Tms7ttzQgceZPstdgsaB___5TeIkEqzZuNt0Cv0uz03Dj9ejbv1___---diagram----e515212c235ffbf517fe4775de67c407.png" alt="" data-element-id="An__4sVAZ0ekUnIb2quuB" /></a>
<!-- end-eraser-additional-files -->
<!-- end-eraser-additional-content -->
<!--- Eraser file: https://app.eraser.io/workspace/Tms7ttzQgceZPstdgsaB --->