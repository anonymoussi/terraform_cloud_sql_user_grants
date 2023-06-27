resource "google_service_account_key" "sa_key" {
  for_each           = { for k, v in var.users : k => v if lookup(v, "create_sa", false) }
  service_account_id = google_service_account.sa[each.key].name
}

resource "google_service_account" "sa" {
  for_each     = { for k, v in var.users : k => v if lookup(v, "create_sa", false) }
  account_id   = each.key
  display_name = each.key
}

resource "google_project_iam_member" "assign_cloudsql_client" {
  for_each = { for k, v in var.users : k => v if lookup(v, "create_sa", false) }
  project  = var.project
  role     = "roles/cloudsql.client"
  member   = "serviceAccount:${google_service_account.sa[each.key].email}"
}
