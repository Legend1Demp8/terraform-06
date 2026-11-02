resource "yandex_compute_instance" "worker" {
  name        = var.each_vm.vm_name
  platform_id = var.each_vm.platform_id
  zone        = var.default_zone

  service_account_id = yandex_iam_service_account.sa_worker.id

  resources {
    cores         = var.each_vm.cpu
    memory        = var.each_vm.ram
    core_fraction = var.each_vm.core_fraction
  }

  scheduling_policy {
    preemptible = var.each_vm.preemptible
  }

  boot_disk {
    initialize_params {
      image_id = var.each_vm.image_id
      size     = var.each_vm.disk_volume
      type     = var.each_vm.disk_type
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.dev_sg.id]
    nat                = var.each_vm.nat
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = var.each_vm.serial_port_enable
  }

  depends_on = [
    yandex_container_registry.registry,
    yandex_container_repository.repository,
    yandex_resourcemanager_folder_iam_member.sa_registry_pusher,
    yandex_mdb_mysql_cluster.cluster,
    yandex_mdb_mysql_database.db,
    yandex_mdb_mysql_user.user,
    yandex_lockbox_secret_version.mysql_password_v1
  ]
}

