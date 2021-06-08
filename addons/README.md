# ADDONS:

With the istio-operator profile yaml, the Istio native componets were deployed. Now that its deployed, Kiali can be deployed as an addon to the Istio as a service to view the traffic and optionally manage the application deployments in Istio.

To expose the Kiali in the istio-system namespace; Istio Gateway(kiali-gateway), Virtual Services and Destination Rules were applied.

The Virtual se
