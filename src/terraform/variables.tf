
# Access to providers
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

# Global settings
variable "tld" {
  description = "Top level domain for the cluster"
  type = string
}

variable "cluster_name" {
  description = "Name of the K8s cluster"
  type = string
  default = "k8s"

  validation {
    condition     = can(regex("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$", var.cluster_name))
    error_message = "Value of cluster_name should be lowercase and can only contain alphanumeric characters and hyphens(-)."
  }
}

# SSH key settings
variable "ssh_public_key_file" {
  description = "SSH public key file"
  type        = string
  default     = "../../data/id_rsa.pub"
}

variable "ssh_private_key_file" {
  # Only used for terraform output as kubeone input
  description = "SSH private key file used to access instances"
  type        = string
  default     = "../../data/id_rsa"
}

variable "ssh_username" {
  # Only used for terraform output as kubeone input
  description = "SSH user"
  type        = string
  default     = "root"
}

variable "ssh_port" {
  # Only used for terraform output as kubeone input
  description = "SSH port to be used to provision instances"
  type        = number
  default     = 22
}

variable "ssh_agent_socket" {
  # Only used for terraform output as kubeone input
  description = "SSH Agent socket, default to grab from $SSH_AUTH_SOCK"
  type        = string
  default     = "env:SSH_AUTH_SOCK"
}