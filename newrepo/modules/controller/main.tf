provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "ansible_controller" {
  ami           = var.amiid
  instance_type = var.instance_type
  key_name      = "devops"
  tags = {
    Name = "Controller"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update && sudo apt install -y ansible && sudo apt install -y python3"
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/terraform/terransible/devops.pem")
    host        = self.public_ip
  }
}

output "id" {
  value = aws_instance.ansible_controller.public_ip
}
