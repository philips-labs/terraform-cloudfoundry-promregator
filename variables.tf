variable "domain" {
  description = "The cf domain that will be used for the route on the promregator app"
  type        = string
  default     = "apps.internal"
}
variable "org_name" {
  description = "The name of the cf organisation to create the promregator instance in"
  type        = string
}
variable "space_id" {
  description = "The id of the cf space to create the promregator instance in"
  type        = string
}
variable "promregator_docker_image" {
  description = "The docker image to use for promregator"
  default     = "promregator/promregator:0.8.5"
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
  type        = map(any)
  default     = {}
}
variable "promregator_targets" {
  description = "A list of maps representing the properties of the target to be configured. These are the config values from propergator targets"
  type        = list(map(any))
}

variable "memory" {
  type        = number
  description = "The amount of memory that should be allocated to the app by CloudFoundry"
  default     = 512
}

variable "disk_quota" {
  type        = number
  description = "The amount of disk space that should be allocated to the promregator app by CloudFoundry"
  default     = 1024
}

variable "instances" {
  type        = number
  description = "The number of instances of the promregator app to be run"
  default     = 1
}