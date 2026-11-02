#Create Network
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

#Create Subnet
resource "yandex_vpc_subnet" "develop" {
  name           = "${var.vpc_name}-${var.default_zone}"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

