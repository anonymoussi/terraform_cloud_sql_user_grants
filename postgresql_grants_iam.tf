resource "google_project_iam_member" "test" {
  for_each = { for k, v in var.users : k => v if lookup(v, "type", "") == "CLOUD_IAM_USER" }
  project  = var.project
  role     = "roles/cloudsql.instanceUser"
  member   = "user:${each.key}"
}

resource "google_project_iam_member" "test_cloudsql_client" {
  for_each = { for k, v in var.users : k => v if lookup(v, "type", "") == "CLOUD_IAM_USER" }
  project  = var.project
  role     = "roles/cloudsql.client"
  member   = "user:${each.key}"
}
