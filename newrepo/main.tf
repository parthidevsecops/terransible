#module "controller" {
# source = "./modules/controller"
#  machinescount = var.machines_count
#}

module "instance" {
  source        = "./modules/ec2"
  amiid         = var.instance_amiid
  type          = var.instance_type
  instances_count = var.instances_count
  user            = var.myuser
  hostsfile      = var.myhostsfile
  playbook   = var.myplaybook
}



