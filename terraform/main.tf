resource "yandex_vpc_network" "this" {
  name = "otus vpc"
}

resource "yandex_vpc_subnet" "this" {
  name           = "otus-subnet-1"
  v4_cidr_blocks = ["10.0.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.this.id
}

resource "yandex_compute_instance" "this" {
  name                      = "task-2"
  platform_id               = "standard-v3"
  zone                      = "ru-central1-a"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8n6sult0bipcm75u12"
      size     = 8
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.this.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/aglumov_id_rsa.pub")}"
  }
}
