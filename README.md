# terraform-cloudfoundry-promregator

Terraform module to deploy promregator to cloudfoundry.

This module will deploy a promregator instance to cloudfoundry and will configure it to aggregate for the org and space name configured in the settings.

You can configure the targets by adding a map to the promregator_targets property with the properties that you would like to configure for that target. The possible values can be seen in [the promregator config](https://github.com/promregator/promregator/blob/master/docs/config.md)

This module does not configure any internal network policies required to allow promregator or prometheus to connect to the apps being monitored. You will need to configure these manually.

## Example usage

```tf
module "promregator" {
  source = "github.com/philips-labs/terraform-cloudfoundry-promregator"

  domain          = "my.domain"
  org_name        = "my-deployment-org"
  space_id        = "my-deployment-space-id"
  cf_api_host     = "api.mycf.com"
  cf_username     = "myuser"
  cf_password     = "mypassword"
  docker_username = "docker-user"
  docker_password = "docker-password"

  promregator_targets = [{
    orgname             = "org-to-be-promregated"
    spacename           = "spacetobepromregated"
    protocol            = "http"
    preferredrouteregex = ".*.apps.internal"
    anotherconfig       = "my value"
  }]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| cloudfoundry | >= 0.1206.0 |

## Providers

| Name | Version |
|------|---------|
| cloudfoundry | >= 0.1206.0 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cf\_api\_host | The cf api host to use for discovery of the apps in the metrics org and space | `string` | n/a | yes |

| cf\_password | Credentials for cf\_api\_host | `string` | n/a | yes |
| cf\_username | Credentials for cf\_api\_host | `string` | n/a | yes |
| docker\_password | The docker password used to pull the promregator\_docker\_image | `string` | `""` | no |
| docker\_username | The docker username used to pull the promregator\_docker\_image | `string` | `""` | no |
| domain | The cf domain that will be used for the route on the promregator app | `string` | `"apps.internal"` | no |
| environment | Environment variables to be passed to the promregator instance. These will be merged with and overwrite the vars set in this module. | `map(any)` | `{}` | no |
| name\_postfix | The postfix string to append to the space, hostname, etc. Prevents namespace clashes | `string` | `""` | no |
| network\_policies | The container-to-container network policies to create with Promregator as the source app | <pre>list(object({<br>    destination_app = string<br>    protocol        = string<br>    port            = string<br>  }))</pre> | `[]` | no |
| org\_name | The name of the cf organisation to create the promregator instance in | `string` | n/a | yes |
| promregator\_docker\_image | The docker image to use for promregator | `string` | `"promregator/promregator:0.8.5"` | no |
| promregator\_targets | A list of objects representing the properties of the target to be configured. These are the config values from propergator targets | `list(object({}))` | n/a | yes |
| space\_id | The id of the cf space to create the promregator instance in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| promregator\_endpoint | The endpoint where Promregator is reachable |
| promregator\_id | The Promregator app id |