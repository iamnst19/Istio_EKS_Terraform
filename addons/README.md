# ADDONS:

## What is Kiali?

Kiali is a management console for an Istio-based service mesh. It provides dashboards, observability, and lets you operate your mesh with robust configuration and validation capabilities. It shows the structure of your service mesh by inferring traffic topology and displays the health of your mesh. Kiali provides detailed metrics, powerful validation, Grafana access, and strong integration for distributed tracing with Jaeger.

## How is Kiali used in this Project?

With the istio-operator profile yaml, the Istio native componets were deployed. Now that its deployed, **Kiali** can be deployed as an addon to the Istio as a service to view the traffic and optionally manage the application deployments in Istio.

To expose the Kiali in the istio-system namespace; Istio Gateway (kiali-gateway), Virtual Services(kiali) and Destination Rules(kiali) were applied.

## Prerequisite for Kiali:

### Promentheus Server:

  - Deploy the Prometheus server to allow the scraping of data to be utilized by the kiali server for metrics and visualization at port '9090'.
### Kiali Secret:

  - The kiali yaml gives the option to set the username and password for Kiali, with the kiali secret.yaml.


### Key Points on Kiali YAML file to edit before applying: 

- Kiali annotations are turned to **"true"** for **sidecar injection** that allows envoy proxies. 

```
pod_annotations:
  sidecar.istio.io/inject: "true"
```
- The ingress options are also turned **"true"** to allow ingress to the kiali pod.

```   
ingress_enabled: "true"
```   
### Key Points on Kiali Virtual Services YAML file:

- The Gateway is set so it accepts all traffic at port **80** comining to the ELB. 
- The Virtual service routes the traffic from the Gateway to the the service FQDN of kiali at port **20001**.
- The Destination rule is set as it **DISABLE** for the TLS traffic. 

## References:

- https://istio.io/latest/blog/2020/addon-rework/
- https://github.com/istio/istio/blob/release-1.10/samples/addons/kiali.yaml
- https://github.com/istio/istio/blob/release-1.10/samples/addons/prometheus.yaml


