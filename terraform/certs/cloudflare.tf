// data "cloudflare_zone" "hostname" {
//   name = var.hostname
// }

// resource "cloudflare_record" "admin" {
//   zone_id = data.cloudflare_zone.hostname.id
//   name    = "admin"
//   value   = "admin.${data.cloudflare_zone.hostname.name}"
//   type    = "CNAME"
//   ttl     = 1
//   proxied = true
// }

// resource "cloudflare_record" "client" {
//   zone_id = data.cloudflare_zone.hostname.id
//   name    = "test"
//   value   = "test.${data.cloudflare_zone.hostname.name}"
//   type    = "CNAME"
//   ttl     = 1
//   proxied = true
// }

data "cloudflare_origin_ca_root_certificate" "origin_ca" {
  algorithm = "rsa"
}