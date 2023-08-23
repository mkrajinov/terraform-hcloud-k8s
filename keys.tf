resource "hcloud_ssh_key" "default" {
  for_each   = toset(var.ssh_keys)
  name       = each.key
  public_key = file("./ssh_keys/${each.key}.pub")
}
