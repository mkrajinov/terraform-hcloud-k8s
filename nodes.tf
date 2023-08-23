resource "hcloud_server" "k8s_nodes" {
  for_each = var.nodes

  name   = "${var.k8s_cluster_name}-${each.value.pool}-node-${each.key}"
  labels = {
    "k8s-cluster" = var.k8s_cluster_name
    "k8s-pool"    = each.value.pool
  }
  image       = var.pools[each.value.pool].image
  server_type = var.pools[each.value.pool].server_type
  location    = var.hcloud_location
  ssh_keys    = var.ssh_keys

  network {
    network_id = hcloud_network.k8s_network[var.pools[each.value.pool].network_id].id
    ip         = each.value.ip
  }

  firewall_ids = [hcloud_firewall.k8s_firewall_nodes.id]

  depends_on = [
    hcloud_network_subnet.k8s_network_subnet,
  ]

  provisioner "remote-exec" {
    inline = ["sudo apt update"]

    connection {
      host  = self.ipv4_address
      type  = "ssh"
      user  = "root"
      agent = true
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' ${path.module}/provisioning/ansible/playbook.yml"
  }
}
