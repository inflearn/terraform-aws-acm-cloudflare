locals {
  domain = "terraform-aws-modules.modules.tf"

  # Removing trailing dot from domain - just to be sure :)
  domain_name = trimsuffix(local.domain, ".")
}

module "acm" {
  source = "../../"

  domain_name = local.domain_name
  zone_id     = cloudflare_zone.this.id

  subject_alternative_names = [
    "*.alerts.${local.domain_name}",
    "new.sub.${local.domain_name}",
    "*.${local.domain_name}",
    "alerts.${local.domain_name}",
  ]

  tags = {
    Name = local.domain_name
  }
}

resource "cloudflare_zone" "this" {
  zone = local.domain_name
}
