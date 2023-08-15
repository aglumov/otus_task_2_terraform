resource "local_file" "ansible_inventory" {
  filename        = "../ansible/inventory.ini"
  file_permission = 0644
  content = templatefile("./inventory.tftpl",
    {
      testvar = yandex_compute_instance.this.network_interface[0].nat_ip_address
    }
  )
}
