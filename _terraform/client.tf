variable "client" {
  type = object({
    working_dir = string
    npm_prefix  = string
    entrypoint  = list(string)
  })
}

resource "docker_container" "client" {
  image = docker_image.node.name
  name  = "client.${var.project_name}"

  volumes {
    host_path      = var.host.client_project_dir
    container_path = var.client.working_dir
  }
  volumes {
    host_path      = var.host.npm_prefix
    container_path = var.client.npm_prefix
    read_only      = true
  }

  env = [
    "npm_config_prefix=${var.client.npm_prefix}",
    "NODE_PATH=${var.client.npm_prefix}/lib/node_modules"
  ]

  ports {
    internal = 80
    external = var.host.client_port
  }
  networks_advanced {
    name = docker_network.network.name
  }

  user        = "node"
  working_dir = var.client.working_dir
  entrypoint  = var.client.entrypoint
  tty         = true
}

output "client_ports" {
  value = docker_container.client.ports
}
