resource "yandex_compute_snapshot_schedule" "daily" {
  name = "daily-snaps"

  schedule_policy {
    expression = "0 3 * * *"
  }

  snapshot_count   = 7
  retention_period = "168h"

  snapshot_spec {
    description = "daily auto"
    labels = {
      env = "prod"
    }
  }

  disk_ids = [
    yandex_compute_instance.web_a.boot_disk[0].disk_id,
    yandex_compute_instance.web_b.boot_disk[0].disk_id,
    yandex_compute_instance.prom.boot_disk[0].disk_id,
    yandex_compute_instance.grafana.boot_disk[0].disk_id,
    yandex_compute_instance.es.boot_disk[0].disk_id,
    yandex_compute_instance.kibana.boot_disk[0].disk_id,
    yandex_compute_instance.bastion.boot_disk[0].disk_id
  ]
}
