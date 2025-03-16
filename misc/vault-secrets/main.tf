terraform {
  backend "s3" {
	bucket = "terraformaddy"
	key    = "vaultsecrets/state"
	region = "us-east-1"
  }
  required_providers {
	vault = {
	  source  = "hashicorp/vault"
	  version = "4.3.0"
	}
  }
}

provider "vault" {
  address= "http://vault-public.doubtfree.online:8200"
  token = var.vault_token

}
variable "vault_token" {}

resource "vault_mount" "ssh" {
  path = "infra"
  type = "kv"
  options = { version = "2" }
  description = "Infra secrets"
}
#store the secrets
resource "vault_generic_secret" "ssh" {
 path = "infra/ssh"
 data_json = <<EOT
{
	"username": "ec2-user",
	"password": "DevOps321"
}
EOT
}