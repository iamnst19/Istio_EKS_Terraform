# ADDONS:

With the istio-operator profile yaml, the Istio native componets were deployed. Now that its deployed, ** Kiali ** can be deployed as an addon to the Istio as a service to view the traffic and optionally manage the application deployments in Istio.

To expose the Kiali in the istio-system namespace; Istio Gateway(kiali-gateway), Virtual Services and Destination Rules were applied.

### Key Points:

- The Gateway is set so it accepts all traffic at port 80 comining to the ELB. 
- The Virtual service routes the traffic from the Gateway to the the service FQDN of kiali at port 20001.
- The Destination rule is set as it disables TLS traffic. 
