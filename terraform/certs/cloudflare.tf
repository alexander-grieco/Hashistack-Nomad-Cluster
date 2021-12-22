data "cloudflare_zone" "hostname" {
  name = "alexgrieco.io"
}

resource "cloudflare_record" "admin" {
  zone_id = data.cloudflare_zone.hostname.id
  name    = "admin"
  value   = "admin.${data.cloudflare_zone.hostname.name}"
  type    = "CNAME"
  ttl     = 3600
}