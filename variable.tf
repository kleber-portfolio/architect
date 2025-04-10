variable "ecr_name" {
  description = "Nome do repositorio de imagens"
  default     = "studio-trek-repo"
}

variable "vpc_name" {
  description = "Nome da VPC"
  default     = "studio-trek-vpc"
}

variable "lb_name" {
  description = "Nome do Load Balance"
  default     = "studio-trek-lb"
}

variable "region" {
  description = "Região de criação do ambiente da AWS"
  type = object({
    dev  = string
    prod = string
  })

  default = {
    dev  = "us-east-1"
    prod = "us-east-1"
  }
}

variable "vpc_cidr" {
  description = "Quantidade de IPs da minha VPC"
  type = object({
    dev  = string
    prod = string
  })

  default = {
    dev  = "10.0.0.0/21"
    prod = "10.0.0.0/16"
  }
}

variable "public_subnets" {
  description = "Subnets públicas por ambiente"

  type = map(map(object({
    cidr_block        = string
    availability_zone = string
  })))

  default = {
    dev = {
      pub_a = {
        cidr_block        = "10.0.1.0/24"
        availability_zone = "us-east-1a"
      }
      pub_b = {
        cidr_block        = "10.0.2.0/24"
        availability_zone = "us-east-1b"
      }
    }
    prod = {
      pub_a = {
        cidr_block        = "10.0.1.0/24"
        availability_zone = "us-east-1a"
      }
      pub_b = {
        cidr_block        = "10.0.2.0/24"
        availability_zone = "us-east-1b"
      }
    }
  }
}

variable "private_subnets" {
  description = "Subnets privadas por ambiente"

  type = map(map(object({
    cidr_block        = string
    availability_zone = string
  })))

  default = {
    dev = {
      priv_a = {
        cidr_block        = "10.0.3.0/24"
        availability_zone = "us-east-1a"
      }
      priv_b = {
        cidr_block        = "10.0.4.0/24"
        availability_zone = "us-east-1b"
      }
    }
    prod = {
      priv_a = {
        cidr_block        = "10.0.3.0/24"
        availability_zone = "us-east-1a"
      }
      priv_b = {
        cidr_block        = "10.0.4.0/24"
        availability_zone = "us-east-1b"
      }
    }
  }
}