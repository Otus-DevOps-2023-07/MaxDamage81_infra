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
  image_name = "reddit-full-${formatdate("MM-DD-YYYY", timestamp())}"
  image_family = "reddit-full"
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
      "sudo apt-get install -y ruby-full ruby-bundler build-essential mongodb git",
      "sudo systemctl enable mongodb",
      "mkdir /home/${var.username}/app/",
      "cd /home/${var.username}/app/",
      "git clone -b monolith https://github.com/express42/reddit.git",
      "cd /home/${var.username}/app/reddit && bundle install",
      "echo '[Unit]\nDescription=App Reddit Full\n[Service]\nWorkingDirectory=/home/${var.username}/app/reddit\nExecStart=/usr/local/bin/puma\n[Install]\nWantedBy=multi-user.target'  > /home/${var.username}/app/app-redditfull.service",
      "sudo systemctl enable /home/${var.username}/app/app-redditfull.service"
    ]
  }


}
