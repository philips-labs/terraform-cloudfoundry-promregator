variable "domain" {
  default = "apps.internal"
}
variable "org_name" {

}
variable "space_name" {

}
variable "promregator_docker_image" {
  default = "promregator/promregator:0.8.5"
}
variable "metrics_orgname" {

}
variable "metrics_spacename" {

}
variable "cf_api_host" {

}
variable "cf_username" {

}
variable "cf_password" {

}
variable "docker_username" {

}
variable "docker_password" {

}
variable "name_postfix" {
  type        = string
  description = "The postfix string to append to the space, hostname, etc. Prevents namespace clashes"
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
  default = {}
}
