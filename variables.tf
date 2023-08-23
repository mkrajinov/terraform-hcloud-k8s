variable "hcloud_location" {
  type    = string
  default = "fsn1"
}

variable "ssh_keys" {
  type = list(string)
}

variable "k8s_cluster_name" {
  type = string
}

variable "control_plane" {
  type = object({
    image       = string
    server_type = string
    network_id  = string
    ip          = string
  })
}

# pools

variable "pools" {
  type = map(object({
    image       = string
    server_type = string
    network_id  = string
  }))
}

# nodes
variable "nodes" {
  type = map(object({
    pool        = string
    ip          = string
  }))
}

# balancers
variable "load_balancers" {
  type = map(object({
    type       = string
    network_id = string
    ip         = string
  }))
}

# networks
variable "network_zone" {
  type = string
}

variable "networks" {
  type = map(object({
    ip_range = string
  }))
}

variable "network_subnets" {
  type = map(object({
    network_id = string
    ip_range   = string
  }))
}

# firewalls
variable "ssh_allowed_ips" {
  type = list(string)
}
