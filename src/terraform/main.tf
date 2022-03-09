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
resource "hcloud_ssh_key" "kubeone" {
  name       = "kubeone-${var.cluster_name}"
  public_key = tls_private_key.ssh.public_key_openssh
}

# Create a network
resource "hcloud_network" "net" {
  name     = var.cluster_name
  ip_range = var.ip_range
}

# Create a subnet for servers in the network
resource "hcloud_network_subnet" "kubeone" {
  network_id   = hcloud_network.net.id
  type         = "cloud"               # type "server" is deprecated
  network_zone = var.network_zone
  ip_range     = var.ip_range
}
