# Setting up Istio in AWS EKS

## Description of the project:
In this project we will be setting up an EKS cluster from sratch, install Istio with the help of istio operators (CRD). Then install a sample app to test the capabilities of istio and use Istio for Traffic Management to the deployed application. 

## About Istio:
Istio is an open source service mesh that layers transparently onto existing distributed applications. Istio’s powerful features provide a uniform and more efficient way to secure, connect, and monitor services. Istio is the path to load balancing, service-to-service authentication, and monitoring – with few or no service code changes.

![istio-architechture](https://istio.io/latest/docs/ops/deployment/architecture/arch.svg)


To know more on the terminologies related to the technology, capabilities, design and architechture plese read the references below. 
### Reference:
- https://istio.io/latest/about/service-mesh/
- https://istio.io/latest/docs/ops/deployment/architecture/

## Objectives:

- Setup an EKS Cluster (https://github.com/iamnst19/Istio_EKS_Terraform/blob/2c0c8bd19cd8266573d6dcf3dfccb8e2e01bdd4b/cluster/README.md)
- Install Istio in the setup EKS cluster (https://github.com/iamnst19/Istio_EKS_Terraform/blob/2c0c8bd19cd8266573d6dcf3dfccb8e2e01bdd4b/cluster/README.md)
- Deploy the sample BookInfo App
- Manage Traffic for the App using Istio


		




