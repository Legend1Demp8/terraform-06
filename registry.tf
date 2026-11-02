resource "yandex_container_registry" "registry" {
  for_each = var.container_registries

  name      = "${var.vpc_name}-${each.key}"
  folder_id = var.folder_id
  labels    = each.value.labels
}

resource "yandex_container_repository" "repository" {
  for_each = var.container_registries
  name = "${yandex_container_registry.registry[each.key].id}/${each.key}-repo"
}

resource "yandex_container_repository_lifecycle_policy" "cleanup_policy" {
  for_each = var.container_registries

  name          = "${var.vpc_name}-${each.key}-cleanup"
  repository_id = yandex_container_repository.repository[each.key].id
  status        = each.value.lifecycle_policy.status

  rule {
    description   = each.value.lifecycle_policy.description
    untagged      = each.value.lifecycle_policy.untagged
    expire_period = each.value.lifecycle_policy.expire_period
  }
}
