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

variable "tld" {
  description = "Top level domain for the cluster"
  type = string
}

variable "cluster_name" {
  description = "Name of the K8s cluster"
  type = string
  default = "k8s"
}
