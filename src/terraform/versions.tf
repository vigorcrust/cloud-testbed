terraform {
    required_version = ">= 1.1.6"

    required_providers {
        hcloud = {
        source = "hetznercloud/hcloud"
        version = "~> 1.33.1"
        }
    }
}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token
}
