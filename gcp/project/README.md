# Terraform Google Cloud Project Module

This Terraform module simplifies the process of provisioning a new Google Cloud project. It handles project creation, enables a specified list of Google Cloud APIs, sets up a billing budget, and configures email notifications for budget thresholds, helping you manage costs effectively.

---

## Features

* **Google Cloud Project Creation**: Provisions a new Google Cloud project with a user-defined name, ID, organization, and billing account.
* **API Management**: Automatically enables a list of specified Google Cloud APIs for the newly created project, ensuring necessary services are available from the start.
* **Billing Budget**: Configures a Google Cloud billing budget for the project, allowing you to set spending limits and proactively manage your cloud expenditures.
* **Billing Notifications**: Sets up email notifications that alert designated recipients when the project's spending approaches or exceeds a defined budget threshold.

---

## Usage

To integrate this module into your Terraform configuration, include it as a module block and provide values for the required variables.

```terraform
module "gcp_project" {
  source = "git::https://github.com/benkorichard/terraform-modules.git//gcp//project?ref=v0.0.1"

  project_name               = "my-new-gcp-project"
  project_id                 = "my-new-gcp-project-12345"
  org_id                     = "your-organization-id" # e.g., "123456789012"
  billing_account            = "your-billing-account-id" # e.g., "012345-ABCDEF-GHIJKL"
  environment                = "development"
  project_services           = [
    "compute.googleapis.com",
    "storage.googleapis.com",
    "logging.googleapis.com",
    "cloudresourcemanager.googleapis.com" # Example of a common service
  ]
  billing_notification_email = "your-email@example.com"
  billing_limit              = 500 # The budget limit in EUR (e.g., 500 will set a budget of 500 EUR)
}
```

## Requirements
Before using this module, ensure you have met the following requirements:

* Terraform: Version 0.13 or later.
* Google Cloud Provider: Your Terraform environment must be configured with the Google Cloud Provider, authenticated with appropriate credentials, and possess the necessary IAM permissions to create projects, enable services, and manage billing accounts and budgets.

---

## Inputs

| Name                           | Description                                                                 | Type           | Default | Required |
| :----------------------------- | :-------------------------------------------------------------------------- | :------------- | :------ | :------- |
| `project_name`                 | The human-readable name of the Google Cloud project.                        | `string`       | n/a     | yes      |
| `project_id`                   | The unique ID of the Google Cloud project. This must be globally unique.    | `string`       | n/a     | yes      |
| `org_id`                       | The ID of the Google Cloud organization under which the project will be created. | `string`       | n/a     | yes      |
| `billing_account`              | The ID of the billing account to associate with the new project.            | `string`       | n/a     | yes      |
| `environment`                  | A label to categorize the project's environment (e.g., `"development"`, `"production"`, `"staging"`). | `string`       | n/a     | yes      |
| `project_services`             | A list of Google Cloud service APIs (e.g., `compute.googleapis.com`) to enable for the project. | `list(string)` | `[]`    | yes      |
| `billing_notification_email`   | The email address that will receive notifications when the billing budget thresholds are met. | `string`       | n/a     | yes      |
| `billing_limit`                | The maximum amount in EUR for the project's billing budget.                 | `number`       | n/a     | yes      |


---

## Resources

The following Google Cloud resources are managed by this Terraform module:

| Name                                           | Type       | Description                                              |
| :--------------------------------------------- | :--------- | :------------------------------------------------------- |
| `google_project.project`                       | `resource` | The main Google Cloud project.                           |
| `google_project_service.services`              | `resource` | Manages the enabling of specified Google Cloud APIs.     |
| `google_monitoring_notification_channel.email` | `resource` | The email notification channel for billing alerts.       |
| `google_billing_budget.billing_budget`         | `resource` | The billing budget configured for the project.           |