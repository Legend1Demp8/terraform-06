resource "yandex_lockbox_secret" "mysql_password" {
  name        = "mysql-user-password"
  description = "Пароль для пользователя управляемой БД MySQL"
  folder_id   = var.folder_id
}

resource "yandex_lockbox_secret_version" "mysql_password_v1" {
  secret_id = yandex_lockbox_secret.mysql_password.id

  entries {
    key        = "password"
    text_value = var.lockbox_mysql_password
  }
}
