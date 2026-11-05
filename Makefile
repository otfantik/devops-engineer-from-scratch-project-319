TF_DIR := terraform

.PHONY: help tf-init tf-plan tf-apply tf-destroy tf-output

help:
	@echo "Terraform:"
	@echo "  make tf-init     — terraform init"
	@echo "  make tf-plan     — terraform plan"
	@echo "  make tf-apply    — terraform apply"
	@echo "  make tf-destroy  — terraform destroy"
	@echo "  make tf-output   — terraform output"

tf-init:
	cd $(TF_DIR) && terraform init

tf-plan:
	cd $(TF_DIR) && terraform plan -out=tfplan

tf-apply:
	cd $(TF_DIR) && terraform apply tfplan

tf-destroy:
	cd $(TF_DIR) && terraform destroy

tf-output:
	cd $(TF_DIR) && terraform output