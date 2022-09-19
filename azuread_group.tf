resource "azuread_group" "ADGroup" {
  display_name     = var.aad_group_name
  owners           = var.aad_group_owners
  security_enabled = true
}