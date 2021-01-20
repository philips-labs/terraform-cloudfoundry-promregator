# terraform-cloudfoundry-promregator
Terraform module to deploy promregator to cloudfoundry


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
| cf\_api\_host | n/a | `any` | n/a | yes |
| cf\_password | n/a | `any` | n/a | yes |
| cf\_username | n/a | `any` | n/a | yes |
| docker\_password | n/a | `any` | n/a | yes |
| docker\_username | n/a | `any` | n/a | yes |
| domain | n/a | `string` | `"apps.internal"` | no |
| environment | n/a | `map` | `{}` | no |
| metrics\_orgname | n/a | `any` | n/a | yes |
| metrics\_spacename | n/a | `any` | n/a | yes |
| name\_postfix | The postfix string to append to the space, hostname, etc. Prevents namespace clashes | `string` | `""` | no |
| network\_policies | The container-to-container network policies to create with Promregator as the source app | <pre>list(object({<br>    destination_app = string<br>    protocol        = string<br>    port            = string<br>  }))</pre> | `[]` | no |
| org\_name | n/a | `any` | n/a | yes |
| promregator\_docker\_image | n/a | `string` | `"promregator/promregator:0.8.5"` | no |
| space\_name | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| promregator\_endpoint | The endpoint where Promregator is reachable |
| promregator\_id | The Promregator app id |