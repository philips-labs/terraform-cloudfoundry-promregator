# terraform-cloudfoundry-promregator

Terraform module to deploy promregator to cloudfoundry.

This module will deploy a promregator instance to cloudfoundry and will configure it to aggregate for the org and space name configured in the settings.

It will attempt to use any `apps.internal` routes first but will fall back on any other route configured for an app.

This module does not configure any internal network policies required to allow promregator or prometheus to connect to the apps being monitored.

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
| metrics\_orgname | The cf org name that we want to get metrics from | `string` | n/a | yes |
| metrics\_spacename | The cf spacename that we want to get the metrics from | `string` | n/a | yes |
| name\_postfix | The postfix string to append to the space, hostname, etc. Prevents namespace clashes | `string` | `""` | no |
| network\_policies | The container-to-container network policies to create with Promregator as the source app | <pre>list(object({<br>    destination_app = string<br>    protocol        = string<br>    port            = string<br>  }))</pre> | `[]` | no |
| org\_name | The name of the cf organisation to create the promregator instance in | `string` | n/a | yes |
| promregator\_docker\_image | The docker image to use for promregator | `string` | `"promregator/promregator:0.8.5"` | no |
| space\_id | The id of the cf space to create the promregator instance in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| promregator\_endpoint | The endpoint where Promregator is reachable |
| promregator\_id | The Promregator app id |
