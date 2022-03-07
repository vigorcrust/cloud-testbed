terraform {
  backend "s3" {
    key                         = "terraform.tfstate"
    region                      = "us-west-1"
    endpoint                    = "s3.us-west-000.backblazeb2.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}
