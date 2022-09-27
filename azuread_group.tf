locals {
  groups = csvdecode(file("${path.module}/groups.csv"))
}

data "azuread_client_config" "current" {}

data "azuread_user" "userinfo" {
  user_principal_name = "admin@SalesledzPvtLtd.onmicrosoft.com"
}

resource "azuread_group" "ADGroup" {
  for_each = { for group in local.groups : group.group_name => group }
  display_name     = each.value.group_name
  owners           = [data.azuread_user.userinfo.object_id]
  security_enabled = true
}

# resource "azuread_group" "QA" {
#   display_name     = "QA"
#   owners           = [data.azuread_user.userinfo.object_id]
#   security_enabled = true
# }

# resource "azuread_group" "Manager" {
#   display_name     = "Manager"
#   owners           = [data.azuread_user.userinfo.object_id]
#   security_enabled = true
# }

# resource "azuread_group" "Engineer" {
#   display_name     = "Engineer"
#   owners           = [data.azuread_user.userinfo.object_id]
#   security_enabled = true
# }

# data "azuread_group" "DevOps" {
#   display_name     = "DevOps"
#   security_enabled = true
# }

# data "azuread_group" "QA" {
#   display_name     = "QA"
#   security_enabled = true
# }

# data "azuread_group" "Engineer" {
#   display_name     = "Engineer"
#   security_enabled = true
# }

# data "azuread_group" "Manager" {
#   display_name     = "Manager"
#   security_enabled = true
# }

# resource "azuread_group_member" "DevOps" {
#   for_each = { for u in azuread_user.users: u.mail_nickname => u if u.department == "DevOps" }

#   group_object_id  = data.azuread_group.DevOps.object_id
#   member_object_id = each.value.id
# }

# resource "azuread_group_member" "QA" {
#   for_each = { for u in azuread_user.users: u.mail_nickname => u if u.department == "QA" }

#   group_object_id  = data.azuread_group.QA.object_id
#   member_object_id = each.value.id
# }

# resource "azuread_group_member" "manager" {
#   for_each = { for u in azuread_user.users: u.mail_nickname => u if u.job_title == "Manager" }

#   group_object_id  = data.azuread_group.Manager.object_id
#   member_object_id = each.value.id
# }

# resource "azuread_group_member" "engineer" {
#   for_each = { for u in azuread_user.users: u.mail_nickname => u if u.job_title == "Engineer" }

#   group_object_id  = data.azuread_group.Engineer.object_id
#   member_object_id = each.value.id
# }