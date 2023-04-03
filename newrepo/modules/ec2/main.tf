## Declare Module
module "ec2" {
  source = "../controller"
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my-machine" {

  # All instances will have the same ami and instance_type
  count         = var.instances_count
  key_name      = var.pemfile
  ami           = var.amiid
  instance_type = var.type # 

  tags = {
    # The count.index allows you to launch a resource 
    # starting with the distinct index number 1 and corresponding to this instance.
    #Name = "Ansible Node-${count.index + 1}"
    Name = " ${var.instance_names}${count.index + 1}"
  }
  provisioner "local-exec" {
    command = "echo Node${count.index + 1} ansible_host=${self.private_ip} ansible_user=${var.user} ansible_ssh_private_key_file=/home/ubuntu/${var.pemfile}.pem >> ${var.hostsfile}"
  }
  provisioner "file" {
    source      = var.hostsfile
    destination = "~/${var.hostsfile}"
  }
  provisioner "file" {
    source      = "${var.pemfile}.pem"
    destination = "~/${var.pemfile}.pem"
    on_failure  = continue
  }
  provisioner "file" {
    source      = "${var.playbook}.yml"
    destination = "${var.playbook}.yml"
  }
  provisioner "remote-exec" {
    inline = [
      "cp ~/${var.hostsfile} /tmp/backups.txt",
      "chmod 400 ${var.pemfile}.pem",
      "export ANSIBLE_HOST_KEY_CHECKING=False; sleep 30; ansible-playbook -i ${var.hostsfile} -u {var.user} --key-file ${var.pemfile}.pem ${var.playbook}.yml"
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/terraform/terransible/${var.pemfile}.pem")
    host        = module.ec2.id
  }
}
