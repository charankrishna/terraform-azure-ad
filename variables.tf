variable "group1_value" {
  type = bool
  default = false
}

variable "aad_group_name" {
  type        = string
  default     = "DevOps"
  description = "Azure Active Directory Group for users"
}