## Cluster setup by Terraform

For the EKS Cluster setup we are using  terraform scripts to setup the cluster from scratch, the ‘.tf’ files for the same can be seen under the cluster folder 

Cluster creation was completed by setting up a simple EC2  bastion host with the following binaries installed as a prerequisite, they are:

- aws cli
- terraform binaries
- kubernetes client (kubectl)
- istio client (istioctl)
    - The Istio Client is used to install the operator ymal "istio-operator.yaml"
    - This will bring up the components such as ISTIOD, INGRESSGATEWAY and EGRESSGATEWAY as deployments 
    - Furthermore this client can be used as a client to interact with Istio for other operation in this project such as viewing profile, injecting sidecar, producing manifests etc.
	