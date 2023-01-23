terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">=3.0.1"
    }
  }
}

variable "project_name" { type = string }

variable "host" {
  type = object({
    npm_prefix         = string
    db_dir             = string
    server_project_dir = string
    client_project_dir = string
    server_port        = number
    client_port        = number
  })
}
