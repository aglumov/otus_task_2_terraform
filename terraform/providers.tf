terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.96"
    }

    local = {
      source  = "hashicorp/local"
      version = "~>2.1.0"
    }

  }
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "aglumov-terraform"
    region   = "ru-central1"
    key      = "yandex.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
}
