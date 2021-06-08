# ADDONS:

With the istio-operator profile yaml, the Istio native componets were deployed. Now that its deployed, **Kiali** can be deployed as an addon to the Istio as a service to view the traffic and optionally manage the application deployments in Istio.

To expose the Kiali in the istio-system namespace; Istio Gateway (kiali-gateway), Virtual Services(kiali) and Destination Rules(kiali) were applied.

## Prerequisite:

### Promentheus Server:

  - Deploy the Prometheus server to allow the scraping of data to be utilized by the kiali server for metric at port '9090'.
### Kiali Secret:

  - The kiali yaml gives the option to set the username and password for Kiali, with the kiali secret.yaml.


## Key Points on Kiali YAML file to edit before applying: 

- Kiali annotations are turned to **"true"** for **sidecar injection** that allows envoy proxies.
- The ingress options are also turned **"true"** to allow ingress to the kiali pod.
-   
## Key Points on Kiali Virtual Services YAML file:

- The Gateway is set so it accepts all traffic at port **80** comining to the ELB. 
- The Virtual service routes the traffic from the Gateway to the the service FQDN of kiali at port **20001**.
- The Destination rule is set as it **DISABLE** for the TLS traffic. 
