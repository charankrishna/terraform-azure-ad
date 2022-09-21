variable "aad_group_owners" {
  description = "AAD Owners"
  default = [
    "admin@SalesledzPvtLtd.onmicrosoft.com",
  ]
}

variable "aad_group_name" {
  type        = string
  default     = "DevOps"
  description = "Azure Active Directory Group for users"
}