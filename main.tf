data "cloudfoundry_org" "org" {
  name = var.org_name
}

data "cloudfoundry_domain" "domain" {
  name = var.domain
}

resource "random_id" "id" {
  byte_length = 8
}

locals {
  postfix_name = var.name_postfix != "" ? var.name_postfix : random_id.id.hex
}

resource "cloudfoundry_route" "promregator" {
  domain   = data.cloudfoundry_domain.domain.id
  space    = var.space_id
  hostname = "promregator-${local.postfix_name}"
}

resource "cloudfoundry_app" "promregator" {
  name         = "promregator-${local.postfix_name}"
  space        = var.space_id
  memory       = 1024
  disk_quota   = 1024
  docker_image = var.promregator_docker_image
  docker_credentials = {
    username = var.docker_username
    password = var.docker_password
  }
  environment = merge({
    PROMREGATOR_TARGETS_0_ORGNAME             = var.metrics_orgname
    PROMREGATOR_TARGETS_0_SPACENAME           = var.metrics_spacename
    PROMREGATOR_TARGETS_0_PROTOCOL            = "http"
    PROMREGATOR_TARGETS_0_PREFERREDROUTEREGEX = ".*.apps.internal"
    CF_API_HOST                               = var.cf_api_host
    CF_USERNAME                               = var.cf_username
    CF_PASSWORD                               = var.cf_password
  }, var.environment)

  routes {
    route = cloudfoundry_route.promregator.id
  }
}

resource "cloudfoundry_network_policy" "promregator" {
  count = length(var.network_policies) > 0 ? 1 : 0

  dynamic "policy" {
    for_each = [for p in var.network_policies : {
      destination_app = p.destination_app
      port            = p.port
      protocol        = p.protocol
    }]
    content {
      source_app      = cloudfoundry_app.promregator.id
      destination_app = policy.value.destination_app
      protocol        = policy.value.protocol == "" ? "tcp" : policy.value.protocol
      port            = policy.value.port
    }
  }
}
