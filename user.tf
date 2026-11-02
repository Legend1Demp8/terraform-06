resource "yandex_iam_service_account" "sa_worker" {
  name        = "${var.vpc_name}-worker-sa"
  description = "Сервисный аккаунт для сборки и деплоя контейнеров на ВМ"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_registry_pusher" {
  folder_id = var.folder_id
  role      = var.registry_pusher_role
  member    = "serviceAccount:${yandex_iam_service_account.sa_worker.id}"
}
