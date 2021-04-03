resource "digitalocean_ssh_key" "terraform" {
  name       = "terraform"
  public_key = file(var.public_key_path)
}
