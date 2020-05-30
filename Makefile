up:
	terraform init
	terraform apply --auto-approve

down:
	terraform destroy --auto-approve

connect:
	gcloud compute ssh --project $(shell terraform output project_id) --zone $(shell terraform output zone) $(shell terraform output vm_name)