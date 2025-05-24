resource "google_project" "project" {
  name       = var.project_name
  project_id = var.project_id
  org_id     = var.org_id

  billing_account = var.billing_account

  labels = {
    environment = var.environment
  }

  deletion_policy = "DELETE"
}

resource "google_project_service" "services" {
  for_each = toset(var.project_services)

  project = google_project.project.id
  service = each.value
}

resource "google_monitoring_notification_channel" "email" {
 display_name = "Notification email"
   type = "email"
   labels = {
     email_address = var.billing_notification_email
   }
 }

resource "google_billing_budget" "billing_budget" {
  billing_account = var.billing_account
  display_name    = "${var.project_name} Budget"
  amount {
    specified_amount {
      currency_code = "EUR"
      units         = var.billing_limit
    }
  }
  threshold_rules {
    threshold_percent = 0.9
  }
  all_updates_rule {
    monitoring_notification_channels = [
      google_monitoring_notification_channel.email.id
    ]
    disable_default_iam_recipients = true
  }
}