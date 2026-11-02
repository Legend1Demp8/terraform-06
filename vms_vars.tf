variable "each_vm" {
  description = "Конфигурация одиночной виртуальной машины"
  type = object({
    vm_name            = string
    platform_id        = string
    cpu                = number
    ram                = number
    core_fraction      = number
    preemptible        = bool
    image_id           = string
    disk_volume        = number
    disk_type          = string
    nat                = bool
    serial_port_enable = number
  })
  default = {
    vm_name            = "web-server-1"
    platform_id        = "standard-v2"
    cpu                = 2
    ram                = 2
    core_fraction      = 20
    preemptible        = true
    image_id           = "fd8bu5qanc4labigou11"
    disk_volume        = 20
    disk_type          = "network-hdd"
    nat                = true
    serial_port_enable = 1
  }
}
