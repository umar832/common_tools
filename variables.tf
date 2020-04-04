variable "deployment_environment" {
  default     = "tools"
  description = "Namespace of the deployment <It will be created>"
}

variable "nexus_service_port" {
  default     = 8083
  description = "Please do not change this ports."
}

variable "tiller_version" {
  default     = "v2.11.0"
  description = "Please provide version of the tiller."
}

variable "tiller_namespace" {
  default     = "kube-system"
  description = "Tiller by default will deploy to kube-system"
}

variable "repo_port" {
  default = 8085
}

variable "email" {
  default = "fuchicorpsolutions@gmail.com"
}

variable "google_project_id" {
  default = "angular-unison-267720"
}

variable "jenkins" {
  type = "map"

  default = {
    admin_user             = "admin"
    admin_password         = "password"
    jenkins_auth_client_id = "id"
    jenkins_auth_secret    = "secret"
    git_token              = "awdiahwd12ehhaiodd"
  }
}

variable "grafana" {
  type = "map"

  default = {
    grafana-version  = "6.0.1"
    grafana_username = "admin"
    grafana_password = "password"
    grafana-name     = "grafana"
    smtp_username    = "smtp-user"
    smtp_password    = "password"
    smtp_host        = "smtp.gmail.com:587"
  }
}

variable "vault" {
  type = "map"

  default = {
    vault_token            = "yourtoken"
    vault_username         = "admin"
    vault_service_port     = "8200"
    vault-name             = "test-vault"
    vault_auth_client_id   = "vault-id"
    vault_auth_secret      = "vault-secret"
    git_token              = "git-token"
  }
}

variable "google_domain_name" {
  default     = "fuchicorp.com"
  description = "Please change to your domain name"
}

variable "deployment_name" {
  default = "common_tools"
}
