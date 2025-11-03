locals {
  meta = "ssh-rsa ${var.ssh_public_key}"
}

resource "yandex_compute_instance" "bastion" {
  name = "bastion"
  platform_id = "standard-v3"
  zone = var.zone_a
  resources { cores = 2 memory = 2 }
  boot_disk { initialize_params { image_id = var.image_id size = 10 } }
  network_interface {
    subnet_id = yandex_vpc_subnet.public_a.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.bastion_sg.id]
  }
  metadata = { ssh-keys = "ubuntu:${local.meta}" }
}

resource "yandex_compute_instance" "web_a" {
  name = "web-a"
  zone = var.zone_a
  resources { cores = 2 memory = 2 }
  boot_disk { initialize_params { image_id = var.image_id size = 10 } }
  network_interface {
    subnet_id = yandex_vpc_subnet.private_a.id
    security_group_ids = [yandex_vpc_security_group.web_sg.id]
  }
  metadata = { ssh-keys = "ubuntu:${local.meta}" }
}

resource "yandex_compute_instance" "web_b" {
  name = "web-b"
  zone = var.zone_b
  resources { cores = 2 memory = 2 }
  boot_disk { initialize_params { image_id = var.image_id size = 10 } }
  network_interface {
    subnet_id = yandex_vpc_subnet.private_b.id
    security_group_ids = [yandex_vpc_security_group.web_sg.id]
  }
  metadata = { ssh-keys = "ubuntu:${local.meta}" }
}

resource "yandex_compute_instance" "prom" {
  name = "prometheus"
  zone = var.zone_a
  resources { cores = 2 memory = 4 }
  boot_disk { initialize_params { image_id = var.image_id size = 20 } }
  network_interface {
    subnet_id = yandex_vpc_subnet.private_a.id
    security_group_ids = [yandex_vpc_security_group.prom_sg.id]
  }
  metadata = { ssh-keys = "ubuntu:${local.meta}" }
}

resource "yandex_compute_instance" "grafana" {
  name = "grafana"
  zone = var.zone_a
  resources { cores = 2 memory = 2 }
  boot_disk { initialize_params { image_id = var.image_id size = 10 } }
  network_interface {
    subnet_id = yandex_vpc_subnet.public_a.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.grafana_sg.id]
  }
  metadata = { ssh-keys = "ubuntu:${local.meta}" }
}

resource "yandex_compute_instance" "es" {
  name = "elasticsearch"
  zone = var.zone_b
  resources { cores = 2 memory = 4 }
  boot_disk { initialize_params { image_id = var.image_id size = 30 } }
  network_interface {
    subnet_id = yandex_vpc_subnet.private_b.id
    security_group_ids = [yandex_vpc_security_group.es_sg.id]
  }
  metadata = { ssh-keys = "ubuntu:${local.meta}" }
}

resource "yandex_compute_instance" "kibana" {
  name = "kibana"
  zone = var.zone_b
  resources { cores = 2 memory = 2 }
  boot_disk { initialize_params { image_id = var.image_id size = 10 } }
  network_interface {
    subnet_id = yandex_vpc_subnet.public_b.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.kibana_sg.id]
  }
  metadata = { ssh-keys = "ubuntu:${local.meta}" }
}
