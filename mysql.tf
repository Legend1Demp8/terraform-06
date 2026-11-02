resource "yandex_mdb_mysql_cluster" "cluster" {
  for_each = var.mysql_clusters

  name        = "${var.vpc_name}-${each.key}"
  environment = each.value.environment
  network_id  = yandex_vpc_network.develop.id
  version     = each.value.version
  
  security_group_ids = [yandex_vpc_security_group.db_sg.id]

  resources {
    resource_preset_id = each.value.resource_preset_id
    disk_type_id       = each.value.disk_type_id
    disk_size          = each.value.disk_size
  }

  dynamic "host" {
    for_each = each.value.hosts
    content {
      zone             = host.value.zone
      subnet_id        = yandex_vpc_subnet.develop.id
      assign_public_ip = host.value.assign_public_ip
    }
  }

  depends_on = [
    yandex_lockbox_secret_version.mysql_password_v1
  ]
}

resource "yandex_mdb_mysql_database" "db" {
  for_each = { for db in var.mysql_databases : "${db.cluster_key}-${db.db_name}" => db }

  cluster_id = yandex_mdb_mysql_cluster.cluster[each.value.cluster_key].id
  name       = each.value.db_name
}


resource "yandex_mdb_mysql_user" "user" {
  for_each = { for usr in var.mysql_users : "${usr.cluster_key}-${usr.username}" => usr }

  cluster_id = yandex_mdb_mysql_cluster.cluster[each.value.cluster_key].id
  name       = each.value.username
  password   = yandex_lockbox_secret_version.mysql_password_v1.entries[0].text_value

  dynamic "permission" {
    for_each = [for db in var.mysql_databases : db if db.cluster_key == each.value.cluster_key]
    content {
      database_name = permission.value.db_name
      roles         = each.value.roles        
    }
  }
}

