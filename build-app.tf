
# Create the resource group
resource "azurerm_resource_group" "acme" {
  name     = "acme"
  location = "westeurope"
}
# Create the Linux App Service Plan
resource "azurerm_app_service_plan" "sp-webapp-acme-1" {
  name                = "sp-webapp-acme-1"
  location            = azurerm_resource_group.acme.location
  resource_group_name = azurerm_resource_group.acme.name
  sku {
    tier = "Free"
    size = "F1"
  }
}
# Create the web app, pass in the App Service Plan ID, and deploy code from a public GitHub repo
resource "azurerm_app_service" "sa-webapp-acme-1" {
  name                = "sa-webapp-acme-1"
  location            = azurerm_resource_group.acme.location
  resource_group_name = azurerm_resource_group.acme.name
  app_service_plan_id = azurerm_app_service_plan.sp-webapp-acme-1.id
  source_control {
    repo_url           = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
    branch             = "master"
    manual_integration = true
    use_mercurial      = false
  }
}
