data "azuread_client_config" "current" {}

data "azuread_user" "userinfo" {
  user_principal_name = "admin@SalesledzPvtLtd.onmicrosoft.com"
}

resource "azuread_group" "ADGroup" {
  display_name     = var.aad_group_name
  owners           = [data.azuread_user.userinfo.object_id]
  security_enabled = true
}