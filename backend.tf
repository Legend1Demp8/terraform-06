terraform {
  backend "s3" {
    endpoints = {
      s3       = "https://storage.yandexcloud.net"
    }
    bucket       = "terraform-state-netology-06"
    region       = "ru-central1"
    key          = "terraform.tfstate"

    use_lockfile = true

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
  }
}
