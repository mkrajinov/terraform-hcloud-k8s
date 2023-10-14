resource "hcloud_server" "k8s_control_plane" {
  name   = "${var.k8s_cluster_name}-control-plane"
  labels = {
    "k8s-cluster" = var.k8s_cluster_name
  }
  image       = var.control_plane.image
  server_type = var.control_plane.server_type
  location    = var.hcloud_location
  ssh_keys    = var.ssh_keys

  network {
    network_id = hcloud_network.k8s_network[var.control_plane.network_id].id
    ip         = var.control_plane.ip
  }

  firewall_ids = [hcloud_firewall.k8s_firewall_control_plane.id]

  connection {
    host  = self.ipv4_address
    type  = "ssh"
    user  = "root"
    agent = true
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update"]
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' ${path.module}/provisioning/ansible/playbook.yml"
  }

  provisioner "remote-exec" {
    inline = ["kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=${var.control_plane.ip} --apiserver-cert-extra-sans=${self.ipv4_address}"]
  }
}
