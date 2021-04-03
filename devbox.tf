resource "digitalocean_droplet" "devbox" {
  image              = "ubuntu-20-04-x64"
  name               = "devbox"
  region             = "blr1"
  size               = "s-4vcpu-8gb"
  private_networking = true
  ssh_keys = [
    digitalocean_ssh_key.terraform.fingerprint
  ]
  user_data = file("./setup/devbox.sh")
}

resource "digitalocean_firewall" "devbox_firewall" {
  name = "ssh-inbound-all-outbound"
  droplet_ids = [
    digitalocean_droplet.devbox.id
  ]
  inbound_rule {
    protocol   = "tcp"
    port_range = "22"
    source_addresses = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  outbound_rule {
    destination_addresses = [
      "0.0.0.0/0",
      "::/0"
    ]
    port_range = "all"
    protocol   = "tcp"
  }
  outbound_rule {
    destination_addresses = [
      "0.0.0.0/0",
      "::/0"
    ]
    port_range = "all"
    protocol   = "udp"
  }
}
