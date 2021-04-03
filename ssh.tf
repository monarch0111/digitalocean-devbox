resource "digitalocean_ssh_key" "terraform" {
  name       = "terraform"
  public_key = file(var.public_key_path)
}

resource "github_user_ssh_key" "devbox_ssh_key" {
  title = "devbox_ssh_key"
  key   = tls_private_key.server_ssh_keypair.public_key_openssh
}

resource "tls_private_key" "server_ssh_keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
