# Hashistack Nomad Cluster on AWS
[![Nomad Version](https://img.shields.io/badge/Nomad%20Version-1.1.0-00bc7f.svg)](https://www.nomadproject.io/downloads) [![Consul Version](https://img.shields.io/badge/Consul%20Version-1.9.6-ca2171.svg)](https://www.consul.io/downloads)


## Pre-Requisites

### AWS
In order to use this repo, you must have the following defined as environment variables in your local system
- AWS_ACCESS_KEY
- AWS_SECRET_ACCESS_KEY
- AWS_DEFAULT_REGION (optional)


### Terraform Cloud Set Up
You will then have to create 3 terraform workspaces within a Terraform Cloud organization. Instructions can be found [here](https://app.terraform.io/signup/account). The accounts will be responsible for running the 3 different pieces of the project: The network setup (VPC, Route53), the TLS certificate setup, and the EC2 (HashiStack) set up. Upon creating your workspaces, make sure they use the same version of Terraform defined in the code (this repo uses Terraform `v0.14.8`) and that you change the method of execution to `local`. You can find this setting in the general settings of your Terraform workspace.

You can name your workspaces (and organization) however you would like, just make sure to update the organization name and workspace name in the `backend` configuration found in the following files:
- [Certs Terraform File](terraform/certs/main.tf)
- [HashiStack Terraform File](terraform/hashistack/main.tf)
- [Network Terraform File](terraform/network/main.tf)

Also make sure from your local CLI that you are logged into your remote Terraform cloud account by running the [terraform login command](https://www.terraform.io/docs/cli/commands/login.html).

### Terraform Variable Set Up
If you would like to automatically set up the required variables (or override the default ones), you can define a file named `terraform.auto.tfvars` in each sub repo (i.e. at the same level as the `main.tf` files) with the variable definitions. An example is shown [here](terraform/hashistack/terraform.tfvars.example). 

## How to Run

WARNING: deploying these resources will result in charges to your AWS account.

### Packer
Navigate to the packer folder and make sure you have configured your AWS environment variables. Then run 

```bash
packer build .
```

This will build the AMI in your AWS account.

### Terraform
The repos must be applied in this order: Network -> Certs -> HashiStack (Note: You can skip the certs repo if you will not be securing your clusters with TLS encryption). 

After running the HashiStack repo you will be presented with a print-out of the public and private IPs of your server instances, as well as the necessary environment variables you must set in your local machine to communicate with your cluster.

NOTE: If you have properly set the environment variables, have updated your domain to point to the Route53 name servers, and you are still getting this error: 

`Error querying servers: Get "http://[SERVER_ADDRESS]:4646/v1/agent/members": dial tcp 127.0.0.1:4646: connect: connection refused`

This may be due to latencies in Route53. This normally happens if you have recently destroyed and then re-applied the configuration and the Route53 records have yet to be fully updated. Wait a couple of minutes before trying again and the problem should resolve itself.

## Future Work
- Create job specs for monitoring and load balancing that work for both TLS enabled and disabled environments
- Terraform the creation of Terraform Cloud Workspaces if possible

## Thank You
Thank you to several members of the HashiCorp team for your very helpful GitHub repos. They often helped me get past the roadblocks I encountered while making this repo.