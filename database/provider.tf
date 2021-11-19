terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}
variable "pvt_key" {}

variable "region" {
  default = "tor1"
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_kubernetes_versions" "do_k8s_versions" {}

output "k8s-versions" {
  value = data.digitalocean_kubernetes_versions.do_k8s_versions.latest_version
}

resource "digitalocean_kubernetes_cluster" "hellok8s" {
  name = "hellok8s"
  region = var.region
  version = data.digitalocean_kubernetes_versions.do_k8s_versions.latest_version

  node_pool {
    name = "worker-pool"
    size = "s-2vcpu-2gb"
    node_count = 1
  }
}
