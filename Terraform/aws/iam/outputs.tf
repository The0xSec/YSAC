output "created_user_names" {
  value = module.iam_users.user_names
}

output "developer_group_users" {
  value = module.iam_users.developer_group_users
}

output "operators_group_users" {
  value = module.iam_users.operators_group_users
}
