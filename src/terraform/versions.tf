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
    }
  }

  backend "s3" {
    key                         = "terraform.tfstate"
    bucket                      = "terraform-my-cloud-k8s"
    region                      = "us-west-1"
    endpoint                    = "s3.us-west-000.backblazeb2.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    access_key                  = var.b2_keyID
    secret_key                  = var.b2_applicationKey
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
