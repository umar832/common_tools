resource "kubernetes_deployment" "vault-fuchicorp-deployment" {
  depends_on = ["kubernetes_namespace.service_tools"]
  depends_on = ["kubernetes_secret.vault_secret"]

  metadata {
    name = "vault-fuchicorp-deployment"

    namespace = "${var.namespace}"

    labels {
      app = "vault-fuchicorp-deployment"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "vault-fuchicorp-deployment"
      }
    }

    template {
      metadata {
        labels {
          app = "vault-fuchicorp-deployment"
        }
      }

      spec {
        volume {
          name = "vault-pvc"

          persistent_volume_claim {
            claim_name = "vault-pvc"
          }
        }

        container {
          name  = "vault"
          image = "vault"

          port {
            container_port = 8200
            protocol       = "TCP"
          }

          security_context {
            capabilities {
              add = ["IPC_LOCK"]
            }
          }

          env {
            name = "VAULT_DEV_ROOT_TOKEN_ID"

            value_from {
              secret_key_ref {
                name = "vault-secret"
                key  = "token"
              }
            }
          }

          volume_mount {
            name       = "vault-pvc"
            mount_path = "/var/run"
          }
        }
      }
    }
  }
}

resource "kubernetes_secret" "vault_secret" {
  depends_on = ["kubernetes_namespace.service_tools"]
  metadata {
    name = "vault-secret"

    namespace = "${var.namespace}"
  }

  data {
    token = "${var.vault_token}"
  }

  type = "Opaque"
}

resource "kubernetes_persistent_volume_claim" "vault_pvc" {
  depends_on = ["kubernetes_namespace.service_tools"]
  depends_on = ["kubernetes_secret.vault_secret"]

  metadata {
    name = "vault-pvc"

    namespace = "${var.namespace}"

    labels {
      app = "vault-fuchicorp-deployment"
    }
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests {
        storage = "10Gi"
      }
    }
  }
}

resource "kubernetes_service" "vault-fuchicorp-service" {
  depends_on = ["kubernetes_namespace.service_tools"]
  depends_on = ["kubernetes_secret.vault_secret"]

  metadata {
    name = "vault-fuchicorp-service"

    namespace = "${var.namespace}"
  }

  spec {
    selector {
      app = "vault-fuchicorp-deployment"
    }

    port {
      protocol    = "TCP"
      port        = "${var.vault_service_port}"
      target_port = 8200
    }

    type = "NodePort"
  }
}
