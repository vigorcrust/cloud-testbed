##### SSH Key mgmt #####
# Generate SSH key pair locally
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
  # Exported attributes
  # - public_key_openssh
  # - private_key_pem
}

# Store public SSH key into file for reference purposes
resource "local_file" "ssh_public_key_file" {
  content         = tls_private_key.ssh.public_key_openssh
  filename        = var.ssh_public_key_file
  file_permission = "0755"
}

# Store private SSH key into file
resource "local_file" "ssh_private_key_file" {
  sensitive_content = tls_private_key.ssh.private_key_pem
  filename          = var.ssh_private_key_file
  file_permission   = "0600"
}########################



# Register public SSH key in Hetzner Cloud
resource "hcloud_ssh_key" "k8s" {
  name       = var.cluster_name
  public_key = tls_private_key.ssh.public_key_openssh
}

# Create a network
resource "hcloud_network" "net" {
  name     = var.cluster_name
  ip_range = var.ip_range
}

# Create a subnet for servers in the network
resource "hcloud_network_subnet" "k8s" {
  network_id   = hcloud_network.net.id
  type         = "cloud"               # type "server" is deprecated
  network_zone = var.network_zone
  ip_range     = var.ip_range
}

# Server placement group which ensures that the VMs are not located on the same physical hardware
resource "hcloud_placement_group" "control_plane" {
  name = var.cluster_name
  type = "spread"

  labels = {
    "cluster_name" = var.cluster_name
  }
}

resource "hcloud_server" "control_plane" {
  count              = var.control_plane_replicas
  name               = "control-plane-${count.index + 1}"
  server_type        = var.control_plane_type
  image              = var.image
  location           = var.datacenter
  placement_group_id = hcloud_placement_group.control_plane.id

  ssh_keys = [
    hcloud_ssh_key.k8s.id,
  ]

  labels = {
    "cluster_name" = var.cluster_name
    "role"         = "api"
  }
}

resource "hcloud_server_network" "control_plane" {
  count     = var.control_plane_replicas
  server_id = element(hcloud_server.control_plane.*.id, count.index)
  subnet_id = hcloud_network_subnet.k8s.id
}
