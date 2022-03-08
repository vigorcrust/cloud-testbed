variable "hcloud_token" {
  description = "Hetzner Cloud access token"
  type = string
  sensitive = true
}

variable "godaddy_key" {
  description = "GoDaddy api key"
  type = string
  sensitive = true
}

variable "godaddy_secret" {
  description = "GoDaddy api key secret"
  type = string
  sensitive = true
}
