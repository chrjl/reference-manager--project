variable "node_image" { default = "node:18-slim" }

provider "docker" {
  host = "unix:///run/user/1001/docker.sock"
}

resource "docker_image" "node" {
  name         = var.node_image
  keep_locally = true
}

resource "docker_network" "network" {
  name = var.project_name
  # internal = true
}
