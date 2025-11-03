resource "yandex_alb_target_group" "tg" {
  name = "web-tg"

  target {
    subnet_id  = yandex_vpc_subnet.private_a.id
    ip_address = yandex_compute_instance.web_a.network_interface[0].ip_address
  }

  target {
    subnet_id  = yandex_vpc_subnet.private_b.id
    ip_address = yandex_compute_instance.web_b.network_interface[0].ip_address
  }
}

resource "yandex_alb_backend_group" "bg" {
  name = "web-bg"

  http_backend {
    name   = "web-http"
    weight = 1
    port   = 80

    target_group_ids = [yandex_alb_target_group.tg.id]

    healthcheck {
      interval = "5s"
      timeout  = "1s"

      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "router" {
  name = "web-router"
}

resource "yandex_alb_virtual_host" "vh" {
  name           = "web-vh"
  http_router_id = yandex_alb_http_router.router.id

  route {
    name = "root"

    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.bg.id
      }
    }
  }
}

resource "yandex_alb_load_balancer" "alb" {
  name               = "alb-public"
  network_id         = yandex_vpc_network.vpc.id
  security_group_ids = [yandex_vpc_security_group.alb_sg.id]

  allocation_policy {
    location {
      zone_id   = var.zone_a
      subnet_id = yandex_vpc_subnet.public_a.id
    }
  }

  listener {
    name = "http"

    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = ["80"]
    }

    http {
      handler {
        http_router_id = yandex_alb_http_router.router.id
      }
    }
  }
}

output "alb_ip" {
  value = yandex_alb_load_balancer.alb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}

