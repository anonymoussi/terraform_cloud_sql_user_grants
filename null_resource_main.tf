module "cloud_sql" {
  source  = "terraform-google-modules/cloud-sql/google"
  version = "3.2.0"
}

resource "null_resource" "mysql_grant" {
  provisioner "local-exec" {
    command = <<EOT
      gcloud sql users create <username> --host % --instance <instance_name> --password <password>
      gcloud sql users set-password <username> --host % --instance <instance_name> --password <password>
      gcloud sql instances patch <instance_name> --database-flags ^/^mysql.allow_local_infile=true
      gcloud sql connect <instance_name> --user <username> --password <password> --database <database_name> --execute "GRANT ALL PRIVILEGES ON \`<database_name>\`.* TO '<username>'@'%'"
    EOT
  }

  depends_on = [module.cloud_sql]
}
