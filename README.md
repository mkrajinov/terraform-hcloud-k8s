# terraform-hcloud-k8s

This module creates a Kubernetes cluster on Hetzner Cloud.

## Usage

```hcl
module "k8s_cluster" {
  source = "mkrajinov/k8s/hcloud"

  k8s_cluster_name = "k8s-cluster"

  network_zone = "eu-central"

  networks     = {
    "01" = {
      ip_range = "10.1.0.0/23"
    }
  }

  network_subnets = {
    "01" = {
      network_id = "01"
      ip_range   = "10.1.0.0/24"
    }
    "02" = {
      network_id = "01"
      ip_range   = "10.1.1.0/24"
    }
  }

  load_balancers = {
    "01" = {
      type       = "lb11"
      network_id = "01"
      ip         = "10.1.1.100"
    }
  }

  control_plane = {
    image       = "debian-12"
    server_type = "cx41"
    network_id  = "01"
    ip          = "10.1.0.100"
  }

  pools = {
    "default" = {
      image       = "debian-12"
      server_type = "cx21"
      network_id  = "01"
    }
  }

  nodes = {
    "01" = {
      pool = "default"
      ip   = "10.1.1.101"
    }
    "02" = {
      pool = "default"
      ip   = "10.1.1.102"
    }
  }

  ssh_allowed_ips = []
  ssh_keys        = []
}

output "k8s_control_plane_ip" {
  value = module.k8s_cluster.k8s_control_plane
}

output "k8s_worker_nodes" {
  value = module.k8s_cluster.k8s_worker_nodes
}

output "k8s_load_balancers" {
  value = module.k8s_cluster.k8s_load_balancers
}
```
