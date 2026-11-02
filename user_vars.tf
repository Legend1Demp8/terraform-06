variable "registry_pusher_role" {
  type        = string
  default     = "container-registry.images.pusher"
  description = "Роль для загрузки (push) Docker-образов в Container Registry"
}
