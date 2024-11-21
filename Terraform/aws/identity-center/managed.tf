resource "aws_ssoadmin_permission_set" "dev_group_permissionsets" {
    count = length(local.dev_managed_policies)
    instance_arn = tolist(data.aws_ssoadmin_instances.example.arns)[0]
    name = local.dev_managed_policies[count.index]
}

resource "aws_ssoadmin_account_assignment" "dev_group_assignments" {
    count = length(local.dev_managed_policies) * length(local.group_names)
    instance_arn = tolist(data.aws_ssoadmin_instances.example.arns)[0]
    permission_set_arn = element(aws_ssoadmin_permission_set.dev_group_permissionsets[*].arn, count.index % length(local.dev_managed_policies))
    principal_type = "GROUP"
    target_id = local.account_id
    target_type = "AWS_ACCOUNT"
    principal_id = substr(element(aws_identitystore_group.groups[*].group_id, count.index % length(local.group_names)), 0, 47)
}
