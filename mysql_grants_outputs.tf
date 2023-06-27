output "mysql_credentials" {
  value = [
    for user in var.mysql_users :
    {
      username = "${user}@${var.cluster_name}"
      password = "${random_password.random[user]["result"]}"
    }
  ]
}