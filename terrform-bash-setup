provider "null" {}

resource "null_resource" "setup" {
  provisioner "local-exec" {
    command = <<-EOF
      wget -O setup.sh https://raw.githubusercontent.com/pricekev91/Terraform/main/docker-serge-alpaca.sh
      bash setup.sh
    EOF
  }
}
