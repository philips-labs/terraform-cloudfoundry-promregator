output "promregator_endpoint" {
  description = "The endpoint where Promregator is reachable"
  value       = cloudfoundry_route.promregator.endpoint
}

output "promregator_id" {
  description = "The Promregator app id"
  value       = cloudfoundry_app.promregator.id
}
