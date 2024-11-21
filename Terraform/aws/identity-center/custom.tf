resource "aws_ssoadmin_permission_set" "vpc_ops" {
    instance_arn = data.aws_ssoadmin_instances.example.arns[0]
    name = "VPC-OPS"
}

resource "aws_ssoadmin_account_assignment" "vpc_ops" {
    instance_arn = data.aws_ssoadmin_instances.example.arns[0]
    permission_set_arn = aws_ssoadmin_permission_set.vpc_ops.arn
    principal_id = aws_identitystore_user.users[0].user_id
    principal_type = "USER"
    target_type = "AWS_ACCOUNT"
    target_id = local.account_id
}

resource "aws_ssoadmin_permission_set_inline_policy" "vpc_ops" {
    inline_policy = file("../permission-lib/vpc-ops.json")
    instance_arn = data.aws_ssoadmin_instances.example.arns[0]
    permission_set_arn = aws_ssoadmin_permission_set.vpc_ops.arn
}