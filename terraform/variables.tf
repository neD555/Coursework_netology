variable "cloud_id" { description = "YC cloud id" }
variable "folder_id" { description = "YC folder id" }

variable "zone_a" { default = "ru-central1-a" }
variable "zone_b" { default = "ru-central1-b" }

variable "access_key" { default = "" }
variable "secret_key" { default = "" }

variable "sa_key_file" { default = "" }
variable "iam_token" { default = "" }

variable "image_id" {
  description = "Ubuntu 22.04 LTS"
  default     = "fd80mrhj8fl2oe87a4e1"
}

variable "ssh_public_key" { description = "ssh public key contents" }
