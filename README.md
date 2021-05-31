## Configuring Istio in AWS EKS  

#Cluster setup by Terraform

For the EKS Cluster setup we are using  terraform scripts to setup the cluster from scratch, the ‘.tf’ files for the same can be seen under the cluster folder 

Cluster creation was completed by setting up a simple EC2  bastion host with the following binaries installed as a prerequisite, they are:

	- aws cli
	- terraform binaries
	- kubernetes client (kubectl)
	- istio client (istioctl)
	


