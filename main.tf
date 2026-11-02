#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yml")

  vars = {
    ssh_public_key = local.ssh_public_key
    registry_id    = one(values(yandex_container_registry.registry)).id
    db_host        = one(one(values(yandex_mdb_mysql_cluster.cluster)).host).fqdn
    db_name        = one(values(yandex_mdb_mysql_database.db)).name
    db_user        = one(values(yandex_mdb_mysql_user.user)).name
    db_password    = yandex_lockbox_secret_version.mysql_password_v1.entries[0].text_value
  }
}
