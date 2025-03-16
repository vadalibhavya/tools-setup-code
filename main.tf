terraform {
  backend "s3" {
	bucket = "terraformaddy"
	key    = "tools/state"
	region = "us-east-1"
  }
}


variable "ami_id" {
	default = "ami-09c813fb71547fc4f"
}
variable "zone_id" {
  default = "Z02980273R2SC8CB35MNX"
}
variable "tools"{
  default = {
	vault = {
	  instance_type= "t3.small"
	  port= 8200


	}
  }
}

module "tool-infra" {
	source = "./module-infra"
  for_each = var.tools
	instance_type = each.value.instance_type
    name = each.key
	ami_id = var.ami_id
  	port = each.value.port
  	zone_id = var.zone_id

}