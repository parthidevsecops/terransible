variable "amiid" {
  default = "ami-038face4e75b6a399"
}
# Creating a Variable for instance_type
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
