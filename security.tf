resource "yandex_vpc_security_group" "dev_sg" {
  name       = "${var.vpc_name}-dev-sg"
  network_id = yandex_vpc_network.develop.id
  folder_id  = var.folder_id

  dynamic "ingress" {
    for_each = var.dev_ingress_rules
    content {
      protocol       = ingress.value.protocol
      description    = ingress.value.description
      port           = ingress.value.port
      v4_cidr_blocks = ingress.value.v4_cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.default_egress_rules
    content {
      protocol       = egress.value.protocol
      description    = egress.value.description
      v4_cidr_blocks = egress.value.v4_cidr_blocks
      from_port      = egress.value.from_port
      to_port        = egress.value.to_port
    }
  }
}


resource "yandex_vpc_security_group" "db_sg" {
  name       = "${var.vpc_name}-db-sg"
  network_id = yandex_vpc_network.develop.id
  folder_id  = var.folder_id

  dynamic "ingress" {
    for_each = local.final_db_ingress_rules
    content {
      protocol       = ingress.value.protocol
      description    = ingress.value.description
      port           = ingress.value.port
      v4_cidr_blocks = ingress.value.v4_cidr_blocks 
    }
  }

  dynamic "egress" {
    for_each = var.default_egress_rules
    content {
      protocol       = egress.value.protocol
      description    = egress.value.description
      v4_cidr_blocks = egress.value.v4_cidr_blocks
      from_port      = egress.value.from_port
      to_port        = egress.value.to_port
    }
  }
}
