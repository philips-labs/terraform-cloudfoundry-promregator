variable "domain" {
  description = "The cf domain that will be used for the route on the promregator app"
  type        = string
  default     = "apps.internal"
}
variable "org_name" {
  description = "The name of the cf organisation to create the promregator instance in"
  type        = string
}
variable "space_name" {
  description = "The name of the cf space to create the promregator instance in"
  type        = string
}
variable "promregator_docker_image" {
  description = "The docker image to use for promregator"
  default     = "promregator/promregator:0.8.5"
  type        = string
}
variable "metrics_orgname" {
  description = "The cf org name that we want to get metrics from"
  type        = string
}
variable "metrics_spacename" {
  description = "The cf spacename that we want to get the metrics from"
  type        = string
}
variable "cf_api_host" {
  description = "The cf api host to use for discovery of the apps in the metrics org and space"
  type        = string
}
variable "cf_username" {
  description = "Credentials for cf_api_host"
  type        = string
}
variable "cf_password" {
  description = "Credentials for cf_api_host"
  type        = string
}
variable "docker_username" {
  description = "The docker username used to pull the promregator_docker_image"
  default     = ""
}
variable "docker_password" {
  description = "The docker password used to pull the promregator_docker_image"
  type        = string
  default     = ""
}
variable "name_postfix" {
  description = "The postfix string to append to the space, hostname, etc. Prevents namespace clashes"
  type        = string
  default     = ""
}
variable "network_policies" {
  description = "The container-to-container network policies to create with Promregator as the source app"
  type = list(object({
    destination_app = string
    protocol        = string
    port            = string
  }))
  default = []
}
variable "environment" {
  description = "Environment variables to be passed to the promregator instance. These will be merged with and overwrite the vars set in this module."
  default     = {}
}
