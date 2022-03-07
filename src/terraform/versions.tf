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

    b2 = {
      source = "Backblaze/b2"
      version = "~> 0.7.1"
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
  key    = "" # required - can be set by env GODADDY_API_KEY
  secret = "" # required - can be set by env GODADDY_API_SECRET
}

# Configure Backblaze S3 provider
provider "b2" {
}
