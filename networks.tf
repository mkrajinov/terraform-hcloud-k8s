resource "hcloud_network" "k8s_network" {
  for_each = var.networks

  name   = "${var.k8s_cluster_name}-network-${each.key}"
  labels = {
    "k8s-cluster" = var.k8s_cluster_name
  }
  ip_range = each.value.ip_range
}

resource "hcloud_network_subnet" "k8s_network_subnet" {
  for_each = var.network_subnets

  network_id   = hcloud_network.k8s_network[each.value.network_id].id
  type         = "server"
  network_zone = var.network_zone
  ip_range     = each.value.ip_range
}
