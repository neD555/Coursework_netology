resource "yandex_vpc_security_group" "bastion_sg" {
  name       = "bastion-sg"
  network_id = yandex_vpc_network.vpc.id
  ingress { protocol = "TCP" port = 22 v4_cidr_blocks = ["0.0.0.0/0"] }
  egress  { protocol = "ANY" v4_cidr_blocks = ["0.0.0.0/0"] }
}

resource "yandex_vpc_security_group" "alb_sg" {
  name       = "alb-sg"
  network_id = yandex_vpc_network.vpc.id
  ingress { protocol = "TCP" port = 80 v4_cidr_blocks = ["0.0.0.0/0"] }
  egress  { protocol = "ANY" v4_cidr_blocks = ["0.0.0.0/0"] }
}

resource "yandex_vpc_security_group" "web_sg" {
  name       = "web-sg"
  network_id = yandex_vpc_network.vpc.id
  ingress { protocol = "TCP" port = 80  predefined_target = "loadbalancer_healthchecks" }
  ingress { protocol = "TCP" port = 80  security_group_id = yandex_vpc_security_group.alb_sg.id }
  ingress { protocol = "TCP" port = 22  security_group_id = yandex_vpc_security_group.bastion_sg.id }
  egress  { protocol = "ANY" v4_cidr_blocks = ["0.0.0.0/0"] }
}

resource "yandex_vpc_security_group" "grafana_sg" {
  name       = "grafana-sg"
  network_id = yandex_vpc_network.vpc.id
  ingress { protocol = "TCP" port = 3000 v4_cidr_blocks = ["0.0.0.0/0"] }
  ingress { protocol = "TCP" port = 22   security_group_id = yandex_vpc_security_group.bastion_sg.id }
  egress  { protocol = "ANY" v4_cidr_blocks = ["0.0.0.0/0"] }
}

resource "yandex_vpc_security_group" "kibana_sg" {
  name       = "kibana-sg"
  network_id = yandex_vpc_network.vpc.id
  ingress { protocol = "TCP" port = 5601 v4_cidr_blocks = ["0.0.0.0/0"] }
  ingress { protocol = "TCP" port = 22   security_group_id = yandex_vpc_security_group.bastion_sg.id }
  egress  { protocol = "ANY" v4_cidr_blocks = ["0.0.0.0/0"] }
}

resource "yandex_vpc_security_group" "prom_sg" {
  name       = "prom-sg"
  network_id = yandex_vpc_network.vpc.id
  ingress { protocol = "TCP" port = 9090 security_group_id = yandex_vpc_security_group.grafana_sg.id }
  ingress { protocol = "TCP" port = 22   security_group_id = yandex_vpc_security_group.bastion_sg.id }
  egress  { protocol = "ANY" v4_cidr_blocks = ["0.0.0.0/0"] }
}

resource "yandex_vpc_security_group" "es_sg" {
  name       = "es-sg"
  network_id = yandex_vpc_network.vpc.id
  ingress { protocol = "TCP" port = 9200 security_group_id = yandex_vpc_security_group.kibana_sg.id }
  ingress { protocol = "TCP" port = 22   security_group_id = yandex_vpc_security_group.bastion_sg.id }
  egress  { protocol = "ANY" v4_cidr_blocks = ["0.0.0.0/0"] }
}
