variable "mysql_clusters" {
  description = "Конфигурация кластеров MySQL"
  type = map(object({
    environment        = string
    version            = string
    resource_preset_id = string
    disk_type_id       = string
    disk_size          = number
    hosts = list(object({
      zone             = string
      assign_public_ip = bool
    }))
  }))
  default = {
    "netology-mysql" = {
      environment        = "PRESTABLE"
      version            = "8.0"
      resource_preset_id = "b2.medium"
      disk_type_id       = "network-hdd"
      disk_size          = 20
      hosts = [
        {
          zone             = "ru-central1-d"
          assign_public_ip = false
        }
      ]
    }
  }
}

variable "mysql_databases" {
  description = "Список создаваемых баз данных в разрезе кластеров"
  type = list(object({
    cluster_key = string
    db_name     = string
  }))
  default = [
    {
      cluster_key = "netology-mysql"
      db_name     = "netology_db"
    }
  ]
}

variable "mysql_users" {
  description = "Список пользователей баз данных"
  type = list(object({
    cluster_key = string
    username    = string
    roles       = list(string)
  }))
  default = [
    {
      cluster_key = "netology-mysql"
      username    = "netology_user"
      roles       = ["ALL"]
    }
  ]
}
