terraform {
  required_version = "~> 1.5.1"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.95.0"
    }
  }
}

resource "yandex_compute_instance" "app" {
  name = "reddit-app"
  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }
#   count = 1
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашнем задании
      image_id = var.app_disk_image
    }
  }
  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = var.subnet_id
    nat       = true
  }
#   provisioner "file" {
#     source      = "files/puma.service"
#     destination = "/tmp/puma.service"
#   }
#   provisioner "remote-exec" {
#     script = "files/deploy.sh"
#   }
  connection {
    type  = "ssh"
    host  = self.network_interface[0].nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }
}
