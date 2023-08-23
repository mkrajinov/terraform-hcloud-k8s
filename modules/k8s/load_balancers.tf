resource "hcloud_load_balancer" "k8s_load_balancers" {
  for_each = var.load_balancers
  labels   = {
    "k8s-cluster" = var.k8s_cluster_name
  }
  name               = "${var.k8s_cluster_name}-load-balancer-${each.key}"
  load_balancer_type = each.value.type
  location           = var.hcloud_location
}

resource "hcloud_load_balancer_network" "k8s_load_balancer_network" {
  for_each         = var.load_balancers
  load_balancer_id = hcloud_load_balancer.k8s_load_balancers[each.key].id
  network_id       = hcloud_network.k8s_network[each.value.network_id].id
  ip               = each.value.ip
}

resource "hcloud_load_balancer_target" "k8s_load_balancer_target_nodes" {
  for_each         = hcloud_server.k8s_nodes

  type             = "server"
  load_balancer_id = hcloud_load_balancer.k8s_load_balancers["01"].id
  server_id        = each.value.id
  use_private_ip   = true
}
