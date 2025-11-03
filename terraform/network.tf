resource "yandex_vpc_network" "vpc" { name = "prod-net" }

resource "yandex_vpc_subnet" "public_a" {
  name           = "public-a"
  zone           = var.zone_a
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.10.1.0/24"]
}

resource "yandex_vpc_subnet" "public_b" {
  name           = "public-b"
  zone           = var.zone_b
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.10.2.0/24"]
}

resource "yandex_vpc_subnet" "private_a" {
  name           = "private-a"
  zone           = var.zone_a
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.20.1.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_subnet" "private_b" {
  name           = "private-b"
  zone           = var.zone_b
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = ["10.20.2.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_gateway" "nat" { name = "nat-gw" }

resource "yandex_vpc_route_table" "rt" {
  name       = "private-rt"
  network_id = yandex_vpc_network.vpc.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat.id
  }
}
