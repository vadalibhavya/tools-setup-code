terraform {
  backend "s3" {
	bucket = "terraformaddy"
	key    = "vaultsecrets/state"
	region = "us-east-1"
  }
}

provider "vault" {
  address= "http://vault-public.doubtfree.online:8200"
  token = var.vault_token

}
variable "vault_token" {}

#store the secrets
resource "vault_generic_secret" "ssh" {
 path = "Infra/ssh"
 data_json = <<EOT
{
	"username": "ec2-user",
	"password": "DevOps321"
}
EOT
}