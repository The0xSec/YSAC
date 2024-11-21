provider "aws" {
  region = "us-east-1"
}

data "aws_ssoadmin_instances" "example" {}

locals {
    group_names = ["dev_group", "qa_group", "prod_group"]
    dev_managed_policies = ["AWSLambda_ReadOnly", "AmazonSNSReadOnlyAccess"]
    user_count = 10
    account_id = "509399606943"
}

resource "random_pet" "user_names" {
  count = local.user_count
  length = 1
}

resource "aws_identitystore_user" "users" {
  count = local.user_count
  identity_store_id = tolist(data.aws_ssoadmin_instances.example.identity_store_ids)[0]

  display_name = random_pet.user_names.*.id[count.index]
  user_name = random_pet.user_names.*.id[count.index]

  name {
    given_name = random_pet.user_names.*.id[count.index]
    family_name = random_pet.user_names.*.id[count.index]
  }
}

resource "aws_identitystore_group" "groups" {
  count = length(local.group_names)
  identity_store_id = tolist(data.aws_ssoadmin_instances.example.identity_store_ids)[0]
  display_name = local.group_names[count.index]
}

resource "aws_identitystore_group_membership" "group_memberships" {
    count = length(local.group_names) * 5
    identity_store_id = tolist(data.aws_ssoadmin_instances.example.identity_store_ids)[0]
    group_id = substr(element(aws_identitystore_group.groups[*].group_id, count.index % length(local.group_names)), 0, 47)
    member_id = substr(element(aws_identitystore_user.users[*].user_id, count.index % local.user_count), 0, 47)
}