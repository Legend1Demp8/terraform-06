variable "container_registries" {
  description = "Настройки Container Registry и политик очистки"
  type = map(object({
    labels = map(string)
    lifecycle_policy = object({
      status        = string
      description   = string
      untagged      = bool
      expire_period = string
    })
  }))
  default = {
    "netology-registry" = {
      labels = {
        environment = "development"
        project     = "diploma"
      }
      lifecycle_policy = {
        status        = "active"
        description   = "Автоматическое удаление старых образов без тегов"
        untagged      = true
        expire_period = "72h"
      }
    }
  }
}
