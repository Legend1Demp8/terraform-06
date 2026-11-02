variable "lockbox_mysql_password" {
  description = "Пароль для пользователя MySQL, сохраняемый в Yandex Lockbox"
  type        = string
  sensitive   = true
  default     = "SuperSecurePassword2026!"
}
