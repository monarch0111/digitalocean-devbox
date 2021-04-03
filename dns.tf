resource "cloudflare_record" "devbox" {
  zone_id = var.cloudflare_zone_id
  name    = "devbox"
  value   = digitalocean_droplet.devbox.ipv4_address
  type    = "A"
  ttl     = 60
}
