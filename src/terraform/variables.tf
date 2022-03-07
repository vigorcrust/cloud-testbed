variable "hcloud_token" {
  sensitive = true
}

variable "b2_keyID" {
  description = "ID of the backblaze key"
  sensitive   = true
  type        = string
}

variable "b2_applicationKey" {
  description = "Secret app key accociated to the backblaze key"
  sensitive   = true
  type        = string
}
