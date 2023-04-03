variable "instance_amiid" {
  default = "ami-038face4e75b6a399"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "user" {
  default = "ubuntu"
}
variable "pemfile" {
  default = "devops"
}
variable "myuser" {
  default = "ubuntu"
}
variable "myhostsfile" {
  default = "hosts"
}
variable "myplaybook" {
  default = "sample"
}
variable "instances_count" {
  type    = number
  default = 1 
}

