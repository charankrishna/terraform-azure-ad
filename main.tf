# Configure the Azure Active Directory Provider
provider "azuread" {}

# Retrieve domain information
data "azuread_domains" "default" {
  only_initial = true
}

locals {
  domain_name = data.azuread_domains.default.domains.0.domain_name
  users       = csvdecode(file("${path.module}/users.csv"))
}

# Create users
resource "azuread_user" "users" {
  for_each = { for user in local.users : user.first_name => user }

  user_principal_name = format(
    "%s%s%s@%s",
    substr(lower(each.value.first_name), 0, 1),
    lower(each.value.last_name),
    "",
    local.domain_name
  )

  password = format(
    "%s%s%s!A",
    lower(each.value.last_name),
    substr(lower(each.value.first_name), 0, 1),
    length(each.value.first_name),
  )
  force_password_change = true

  display_name = "${each.value.first_name} ${each.value.last_name}"
  department   = each.value.department
  job_title    = each.value.job_title
}