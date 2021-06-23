# Application Deployment and Ingress via ISTIO

For the application deployment; just followed the steps mentioned in the Istio official documentation for the Sample Application
Apart from that a Rolling update strategy has been implemented 

```
strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
    type: RollingUpdate
```

Also added a Virtual Service that connects the productpage with the reviews and details page under the bookinfo-gateway.yaml file.


![Application Diagram](https://istio.io/latest/docs/examples/bookinfo/withistio.svg)

## Reference: 
   - https://istio.io/latest/docs/examples/bookinfo/