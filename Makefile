build:
	cd terraform && \
		rm -rf .terraform && \
		terraform init -backend-config=scratch-backend.tfvars && \
		terraform plan -var-file=scratch.tfvars -var-file=scratch-backend.tfvars && \
		terraform apply -var-file=scratch.tfvars -var-file=scratch-backend.tfvars -auto-approve

destroy:
	cd terraform && \
		rm -rf .terraform && \
		terraform init -backend-config=scratch-backend.tfvars && \
		terraform plan -var-file=scratch.tfvars -var-file=scratch-backend.tfvars -destroy && \
		terraform destroy -var-file=scratch.tfvars -var-file=scratch-backend.tfvars -auto-approve