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

  user_principal_name = each.value.user_principal_name

  password = format(
    "%s%s%s!A",
    lower(each.value.last_name),
    substr(lower(each.value.first_name), 0, 1),
    length(each.value.first_name),
  )
  force_password_change = true

  display_name = "${each.value.first_name} ${each.value.last_name}"
  department   = each.value.department
}

# data "azuread_group" "group1" {
#   display_name     = "group1"
#   security_enabled = true
# }

# resource "azuread_group_member" "example" {
#   group_object_id  = data.azuread_group.group1.id
#   member_object_id = azuread_user.users[each.key].id
# }

data "azuread_user" "user" {
  for_each = { for i , user in local.users : i => user }
  user_principal_name = each.value.user_principal_name
}

data "azuread_group" "group1" {
  display_name     = "group1"
  security_enabled = true
}

resource "azuread_group_member" "member" {
  for_each = { for i,user in local.users : i => user  if user.group1 }
  group_object_id  = data.azuread_group.group1.id
  member_object_id = data.azuread_user.user[each.key].id
}