## Devbox Setup

Setup an instance on DigitalOcean with firewall and update it's IP on cloudflare DNS.

### Steps
```shell
mv secret.tfvars.example secret.tfvars
terraform apply -var-file="secret.tfvars"
```
