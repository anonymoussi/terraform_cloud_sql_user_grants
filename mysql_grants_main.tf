resource "mysql_database" "cloud_sql" {
  for_each = var.mysql_databases
  name     = each.key
}

resource "mysql_user" "cloud_sql" {
  for_each           = var.mysql_users
  user               = each.value
  host               = "%"
  tls_option         = "SSL"
  plaintext_password = random_password.random[each.value].result
}

resource "mysql_grant" "cloud_sql" {
  for_each   = var.mysql_grants
  user       = mysql_user.cloud_sql[each.value["name"]].user
  host       = "10.%.%.%"
  database   = each.value["database"]
  privileges = each.value["grant"]
}

resource "random_password" "random" {
  for_each = var.mysql_users
  length   = 32
  special  = false
}
