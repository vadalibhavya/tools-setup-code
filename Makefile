infra:
	git pull
	terraform init
	terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve