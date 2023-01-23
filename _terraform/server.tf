variable "server" {
  type = object({
    working_dir = string
    db_dir      = string
    npm_prefix  = string
    entrypoint  = list(string)
  })
}

resource "docker_container" "server" {
  image = docker_image.node.name
  name  = "server.${var.project_name}"

  volumes {
    host_path      = var.host.server_project_dir
    container_path = var.server.working_dir
  }
  volumes {
    host_path      = var.host.npm_prefix
    container_path = var.server.npm_prefix
    read_only      = true
  }
  volumes {
    host_path      = var.host.db_dir
    container_path = var.server.db_dir
  }

  env = [
    "npm_config_prefix=${var.server.npm_prefix}",
    "NODE_PATH=${var.server.npm_prefix}/lib/node_modules"
  ]

  ports {
    internal = 3000
    external = var.host.server_port
  }
  networks_advanced {
    name = docker_network.network.name
  }

  user        = "node"
  working_dir = var.server.working_dir
  entrypoint  = var.server.entrypoint
  tty         = true
}

output "server_ports" {
  value = docker_container.server.ports
}
