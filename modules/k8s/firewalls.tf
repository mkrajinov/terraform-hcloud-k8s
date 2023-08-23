resource "hcloud_firewall" "k8s_firewall_control_plane" {
  name   = "k8s-firewall-control-plane"
  labels = {
    "k8s-cluster" = var.k8s_cluster_name
  }

  rule {
    description = "Allow SSH access"
    direction   = "in"
    protocol    = "tcp"
    port        = "22"
    source_ips  = var.ssh_allowed_ips
  }

  rule {
    description = "Allow https port"
    direction   = "in"
    protocol    = "tcp"
    port        = "443"
    source_ips  = ["0.0.0.0/0"]
  }

  rule {
    description = "Allow PI Server Port"
    direction   = "in"
    protocol    = "tcp"
    port        = "6443"
    source_ips  = ["0.0.0.0/0"]
  }

  rule {
    description = "etcd server client API"
    direction = "in"
    protocol  = "tcp"
    port      = "2379-2380"
    source_ips  = ["0.0.0.0/0"]
  }

  rule {
    description = "Allow Kubelet API"
    direction = "in"
    protocol  = "tcp"
    port      = "10250"
    source_ips  = ["0.0.0.0/0"]
  }

  rule {
    description = "Allow kube-scheduler"
    direction = "in"
    protocol  = "tcp"
    port      = "10259"
    source_ips  = ["0.0.0.0/0"]
  }

  rule {
    description = "Allow kube-controller-manager"
    direction = "in"
    protocol  = "tcp"
    port      = "10257"
    source_ips  = ["0.0.0.0/0"]
  }
}

resource "hcloud_firewall" "k8s_firewall_nodes" {
  name   = "k8s-firewall-nodes"
  labels = {
    "k8s-cluster" = var.k8s_cluster_name
  }

  rule {
    description = "Allow SSH access"
    direction   = "in"
    protocol    = "tcp"
    port        = "22"
    source_ips  = var.ssh_allowed_ips
  }

  rule {
    description = "Allow https port"
    direction   = "in"
    protocol    = "tcp"
    port        = "443"
    source_ips  = ["0.0.0.0/0"]
  }

  rule {
    description = "Allow Kubelet API"
    direction = "in"
    protocol  = "tcp"
    port      = "10250"
    source_ips  = ["0.0.0.0/0"]
  }

  rule {
    description = "Allow NodePort Range"
    direction = "in"
    protocol  = "tcp"
    port      = "30000-32767"
    source_ips  = ["0.0.0.0/0"]
  }
}
