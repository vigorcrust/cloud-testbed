
### Access to providers
variable "hcloud_token" {
  description = "Hetzner Cloud access token"
  type        = string
  sensitive   = true
}

variable "godaddy_key" {
  description = "GoDaddy api key"
  type        = string
  sensitive   = true
}

variable "godaddy_secret" {
  description = "GoDaddy api key secret"
  type        = string
  sensitive   = true
}

### Global settings
variable "tld" {
  description = "Top level domain for the cluster"
  type        = string
}

variable "cluster_name" {
  description = "Name of the K8s cluster"
  type        = string
  default     = "k8s"

  validation {
    condition     = can(regex("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$", var.cluster_name))
    error_message = "Value of cluster_name should be lowercase and can only contain alphanumeric characters and hyphens(-)."
  }
}

variable "datacenter" {
  description = "value"
  type        = string
  default     = "fsn1"

  validation {
    condition     = var.datacenter == "nbg1" || var.datacenter == "fsn1" || var.datacenter == "hel1"
    error_message = "Only nbg1, fsn1 or hel1 are available."
  }
}

### SSH key settings
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

### Network variables
variable "ip_range" {
  description = "IP range to use for private network."
  type        = string
  default     = "192.168.0.0/16"

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))$", var.ip_range))
    error_message = "Only a valid CIDR IP address range is allowed."
  }
}

variable "network_zone" {
  description = "Grouping of inter-connected locations"
  type        = string
  default     = "eu-central"

  validation {
    condition     = var.network_zone == "eu-central" || var.network_zone == "us-east"
    error_message = "Only eu-central or us-east are available."
  }
}

# number and type of VMs
variable "control_plane_replicas" {
  description = "Number of control plane servers"
  type        = number
  default     = 3
}

variable "control_plane_type" {
  description = "Server type"
  type        = string
  default     = "cx21"
}

variable "image" {
  description = "OS image"
  type        = string
  default     = "ubuntu-20.04"
}
