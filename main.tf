terraform {

  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "terraformer-bootcamp-2023""

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
   organization = "terraformer-bootcamp-2023"
   workspaces {
     name = "terra-house-1"
   }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_akara_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.akara.public_path
  content_version = var.akara.content_version
}

resource "terratowns_home" "home" {
  name = "How to make akara!"
  description = <<DESCRIPTION
Akara is a popular Nigerian street food made from black-eyed peas, also known as cowpeas. 
It's a deep-fried bean cake that's crispy on the outside and soft on the inside. Here's a 
simple recipe for making Nigerian Akara:
DESCRIPTION
  domain_name = module.home_akara_hosting.domain_name
  town = "cooker-cove"
  content_version = var.akara.content_version
}

module "home_pancake_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.pancake.public_path
  content_version = var.pancake.content_version
}

resource "terratowns_home" "home_pancake" {
  name = "Make home-made pancake"
  description = <<DESCRIPTION
A pancake is a flat, round, and typically thin batter-based dish, usually made 
from a mixture of flour, eggs, milk or water, and a leavening agent. It's cooked on 
a hot surface or pan and often served for breakfast or as a sweet or savory snack. 
Pancakes are versatile and can be customized with various toppings like syrup, fruits, 
chocolate chips, or whipped cream to suit individual preferences.
DESCRIPTION
  domain_name = module.home_pancake_hosting.domain_name
  town = "cooker-cove"
  content_version = var.pancake.content_version
}