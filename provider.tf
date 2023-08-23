terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.42.0"
    }
  }
}

variable "hcloud_api_token" {
  type = string
}

provider "hcloud" {
  token = var.hcloud_api_token
}
