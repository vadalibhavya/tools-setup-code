infra:
	git pull
	terraform init
	terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve

ansible:
	git pull
	ansible-playbook -i $(tool_name)-private.doubtfree.online, -e ansible_user=ec2-user -e ansible_password=DevOps321 -e tool_name=$(tool_name) setup-tool.yml