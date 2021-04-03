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
  connection {
    host        = digitalocean_droplet.devbox.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key_path)
    timeout     = "2m"
  }
  provisioner "file" {
    content     = tls_private_key.server_ssh_keypair.private_key_pem
    destination = "/root/.ssh/id_rsa"
  }
  provisioner "file" {
    content     = tls_private_key.server_ssh_keypair.public_key_pem
    destination = "/root/.ssh/id_rsa.pub"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod 400 ~/.ssh/id_rsa"
    ]
  }
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
