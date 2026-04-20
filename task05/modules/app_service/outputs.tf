output "id" {
  description = "id of web app"
  value       = azurerm_windows_web_app.windows_web_app.id
}

output "name" {
  description = "name of web app"
  value       = azurerm_windows_web_app.windows_web_app.name
}

output "hostname" {
  description = "hostname of web app"
  value       = azurerm_windows_web_app.windows_web_app.default_hostname
}