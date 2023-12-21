provider "null" {}

resource "null_resource" "install_docker" {
  provisioner "local-exec" {
    command = <<-EOF
      sudo apt update
      sudo apt install apt-transport-https ca-certificates curl software-properties-common
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
      sudo apt update
      sudo apt install docker-ce -y
    EOF
  }
}

resource "null_resource" "install_git" {
  provisioner "local-exec" {
    command = "sudo apt install git -y"
  }
}

resource "null_resource" "clone_serge" {
  provisioner "local-exec" {
    command = "sudo git clone https://github.com/serge-chat/serge"
  }
}

resource "null_resource" "build_docker_image" {
  provisioner "local-exec" {
    command = "cd serge && sudo docker build -t serge ."
  }
}

resource "null_resource" "run_docker_container" {
  provisioner "local-exec" {
    command = "sudo docker run -d --restart always -p 8008:8008 -v /mnt/ai-models/WizardLM-Uncensored-30B.bin:/usr/src/app/weights/WizardLM-Uncensored-30B.bin serge"
  }
}
