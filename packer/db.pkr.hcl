variable folder_id {
    type = string
}

variable source_id{
    type = string
}

variable keyfile {
  type = string
}

variable username {
  type = string
}

variable ipv4_nat {
  type = string
}

variable zone {
  type = string
}

source "yandex" "ubuntu16" {
  service_account_key_file = var.keyfile
  folder_id = var.folder_id
  source_image_family = var.source_id
  image_name = "reddit-db-base-${formatdate("MM-DD-YYYY", timestamp())}"
  image_family = "reddit-db-base"
  ssh_username = var.username
  subnet_id = "e9bkuibq1vtnre11mk3b"
  use_ipv4_nat = var.ipv4_nat
  platform_id = "standard-v1"
  zone = var.zone
}

build {
  sources = ["source.yandex.ubuntu16"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update -y",
      "echo Waiting for apt-get to finish...",
      "a=1; while [ -n \"$(pgrep apt-get)\" ]; do echo $a; sleep 1s; a=$(expr $a + 1); done",
      "echo Done.",
      "sudo apt-get install -y mongodb",
      "sudo systemctl enable mongodb",
    ]
  }


}
