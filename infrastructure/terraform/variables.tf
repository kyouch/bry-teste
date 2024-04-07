variable "kubernetes_name" {
  type    = string
  default = "bry-teste"
}

variable "key_name" {
  type    = string
  default = "bry-teste"
}

variable "key_public" {
  type      = string
  sensitive = true
}

variable "worker_count" {
  type    = number
  default = 2
}

variable "instance_type" {
  type = map(string)
  default = {
    master = "t2.medium"
    worker = "t2.micro"
  }
}

variable "cidr_vpc" {
  type    = string
  default = "10.0.0.0/16"
}

variable "cidr_public_subnet" {
  type    = list
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
