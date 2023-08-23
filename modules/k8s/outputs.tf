output "k8s_control_plane" {
  value       = hcloud_server.k8s_control_plane.ipv4_address
  description = "Control Plane IP"
}

output "k8s_worker_nodes" {
  value = {
    for key, node in hcloud_server.k8s_nodes :
    key => {
      name = node.name
      id = node.id
      public_ip = node.ipv4_address
    }
  }
}

output "k8s_load_balancers" {
  value = {
    for key, node in hcloud_load_balancer.k8s_load_balancers :
    key => {
      id = node.id
      ip = hcloud_load_balancer.k8s_load_balancers[key].ipv4
    }
  }

  description = "LoadBalancer IP"
}
