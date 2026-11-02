##################### Default rules

variable "default_ingress_rules" {
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    from_port      = number
    to_port        = number
  }))
  default = [
    { protocol = "TCP", description = "Allow SSH incoming traffic", v4_cidr_blocks = ["0.0.0.0/0"], from_port = 0, to_port = 65535 }
  ]
}

variable "default_egress_rules" {
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    from_port      = number
    to_port        = number
  }))
  default = [
    { protocol = "ANY", description = "Allow all outbound traffic", v4_cidr_blocks = ["0.0.0.0/0"], from_port = 0, to_port = 65535 }
  ]
}

##################### Custom rules

variable "dev_ingress_rules" {
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = number
  }))
  default = [
    { protocol = "TCP", description = "SSH access", v4_cidr_blocks = ["0.0.0.0/0"], port = 22 },
    { protocol = "TCP", description = "HTTP traffic", v4_cidr_blocks = ["0.0.0.0/0"], port = 80 },
    { protocol = "TCP", description = "HTTPS traffic", v4_cidr_blocks = ["0.0.0.0/0"], port = 443 }
  ]
}

variable "db_ingress_rules" {
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = optional(list(string))#list(string)
    port           = number
  }))
  default = [
    { protocol = "TCP", description = "MYSQL for develop access", port = 3306 },
    { protocol = "TCP", description = "Test", v4_cidr_blocks = ["1.10.10.1/32"], port = 666 }
  ]
}

locals {
  final_db_ingress_rules = [
    for rule in var.db_ingress_rules : {
      protocol    = rule.protocol
      description = rule.description
      port        = rule.port
      
      v4_cidr_blocks = rule.v4_cidr_blocks == null ? var.default_cidr : (length(rule.v4_cidr_blocks) == 0 ? var.default_cidr : rule.v4_cidr_blocks)
    }
  ]
}
