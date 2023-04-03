variable "instances_count" {
  default = 2
}
variable "amiid" {
  default = "ami-038face4e75b6a399"
}
# Creating a Variable for instance_type
variable "type" {
  type    = string
  default = "t2.micro"
}
variable "instance_names" {
  default = "Node"
}
variable "pemfile" {
  default = "devops"
}
variable "user" {
  default = "ubuntu"
}
variable "hostsfile" {
  default = "hosts"
}
variable "playbook" {
  default = "sample"
}
