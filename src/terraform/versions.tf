terraform {
  required_version = ">= 1.1.6"

  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~> 1.33.1"
    }

    godaddy = {
      source = "kolikons/godaddy"
      version = "~> 1.8.1"
    }
  }
}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token         = var.hcloud_token               # required - can be set by env HCLOUD_TOKEN
  endpoint      = "https://api.hetzner.cloud/v1" # optional - default
  poll_interval = "500ms"                        # optional - default
}

# Configure GoDaddy DNS Provider
provider "godaddy" {
  key    = var.godaddy_key # required - can be set by env GODADDY_API_KEY
  secret = var.godaddy_key # required - can be set by env GODADDY_API_SECRET
}
