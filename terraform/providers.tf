terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.138.0"
    }
  }
  required_version = ">= 1.3"
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone_a

  # Выберите один из вариантов аутентификации
  # Вариант 1 статические ключи
  access_key = var.access_key
  secret_key = var.secret_key

  # Вариант 2 json ключ сервисного аккаунта
  # service_account_key_file = var.sa_key_file

  # Вариант 3 iam token
  # token = var.iam_token
}
