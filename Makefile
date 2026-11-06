TF_DIR := terraform
HELM_CHART := k8s/bulletin-board
RELEASE_NAME := bulletins-app
NAMESPACE := bulletins

.PHONY: help tf-init tf-plan tf-apply tf-destroy tf-output app-deploy app-rollback app-history monitoring-deploy monitoring-delete

help:
	@echo "Terraform:"
	@echo "  make tf-init       — terraform init"
	@echo "  make tf-plan       — terraform plan"
	@echo "  make tf-apply      — terraform apply"
	@echo "  make tf-destroy    — terraform destroy"
	@echo "  make tf-output     — terraform output"
	@echo "Helm (Application):"
	@echo "  make app-deploy    — helm upgrade --install bulletins-app"
	@echo "  make app-rollback  — helm rollback to previous revision"
	@echo "  make app-history   — helm history"
	@echo "Monitoring:"
	@echo "  make monitoring-deploy — install kube-prometheus-stack and ServiceMonitor"
	@echo "  make monitoring-delete — uninstall monitoring stack"

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

app-deploy:
	helm upgrade --install $(RELEASE_NAME) $(HELM_CHART) -n $(NAMESPACE) -f $(HELM_CHART)/values-secret.yaml

app-rollback:
	helm rollback $(RELEASE_NAME) -n $(NAMESPACE)

app-history:
	helm history $(RELEASE_NAME) -n $(NAMESPACE)

monitoring-deploy:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update
	helm upgrade --install prometheus prometheus-community/kube-prometheus-stack \
		--namespace monitoring --create-namespace \
		-f helm/values-prometheus.yml
	kubectl apply -f k8s/07-monitoring.yml

monitoring-delete:
	helm uninstall prometheus -n monitoring
	kubectl delete namespace monitoring