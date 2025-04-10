variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "public_subnets" {
  type = map(map(object({
    cidr_block        = string
    availability_zone = string
  })))
}

variable "private_subnets" {
  type = map(map(object({
    cidr_block        = string
    availability_zone = string
  })))
}