# Google Cloud Always free vm template

This repository contains a terraform template to automatically deploy a vm in google cloud that aligns with the always free [specifications](https://cloud.google.com/free/docs/gcp-free-tier#always-free)

## dependencies

- terraform >= v0.12.x
- google cloud cli (gcloud) >= 242.0.0
- google cloud account
- make

## instructions

1. Log into google cloud account using gcloud cli

Authenticated account needs to have access to generating projects and link the project to a billing account.

```sh
gcloud auth application-default login
```

2. Create a terraform.tfvars file and add the correct billing account id

format is like this:

```
billing_account_id = "xxx"
```

3. Deploy the VM using the make file

```sh
make up
```

4. Connect to the instance using the connect command defined in the make file

```sh
make connect
```