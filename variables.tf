variable "aad_owners" {
  description = "AAD Owners"
  default = [
    "admin@SalesledzPvtLtd.onmicrosoft.com"
  ]
}

variable "aad_group_name" {
  type        = string
  default     = "ADUsers"
  description = "Azure Active Directory Group for users"
}