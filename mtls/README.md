# mTls:

## What is Mutual TLS?

## How it works?

## Demo Setup:

### Create two namespaces, foo and bar, and deploy httpbin and sleep with sidecars on both of them:
```
$ kubectl create ns foo
$ kubectl apply -f <(istioctl kube-inject -f httpbin.yaml) -n foo
$ kubectl apply -f <(istioctl kube-inject -f sleep.yaml) -n foo
$ kubectl create ns bar
$ kubectl apply -f <(istioctl kube-inject -f httpbin.yaml) -n bar
$ kubectl apply -f <(istioctl kube-inject -f sleep.yaml) -n bar
```
### Create another namespace, legacy, and deploy sleep without a sidecar:

```
$ kubectl create ns legacy
$ kubectl apply -f samples/sleep/sleep.yaml -n legacy
```

### Verify the setup by sending http requests (using curl) from the sleep pods, in namespaces foo, bar and legacy, to httpbin.foo and httpbin.bar. All requests should succeed with return code 200.

```
$ for from in "foo" "bar" "legacy"; do for to in "foo" "bar"; do kubectl exec "$(kubectl get pod -l app=sleep -n ${from} -o jsonpath={.items..metadata.name})" -c sleep -n ${from} -- curl http://httpbin.${to}:8000/ip -s -o /dev/null -w "sleep.${from} to httpbin.${to}: %{http_code}\n"; done; done

```
***output***
```
sleep.foo to httpbin.foo: 200
sleep.foo to httpbin.bar: 200
sleep.bar to httpbin.foo: 200
sleep.bar to httpbin.bar: 200
sleep.legacy to httpbin.foo: 200
sleep.legacy to httpbin.bar: 200
```

## Lock down to mutual TLS by namespace
After migrating all clients to Istio and injecting the Envoy sidecar, you can lock down workloads in the foo namespace to only accept mutual TLS traffic.

**mtls-ns.yaml**
```
$ kubectl apply -n foo -f - <<EOF
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: "default"
spec:
  mtls:
    mode: STRICT
EOF
```
***Now, you should see the request from sleep.legacy to httpbin.foo failing.***

```
$ for from in "foo" "bar" "legacy"; do for to in "foo" "bar"; do kubectl exec "$(kubectl get pod -l app=sleep -n ${from} -o jsonpath={.items..metadata.name})" -c sleep -n ${from} -- curl http://httpbin.${to}:8000/ip -s -o /dev/null -w "sleep.${from} to httpbin.${to}: %{http_code}\n"; done; done
```
**output**
```
sleep.foo to httpbin.foo: 200
sleep.foo to httpbin.bar: 200
sleep.bar to httpbin.foo: 200
sleep.bar to httpbin.bar: 200
sleep.legacy to httpbin.foo: 000
command terminated with exit code 56
sleep.legacy to httpbin.bar: 200
```


## Lock down mutual TLS for the entire mesh

**mtls-global.yaml**

```
$ kubectl apply -n istio-system -f - <<EOF
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: "default"
spec:
  mtls:
    mode: STRICT
EOF
```
***Now, both the foo and bar namespaces enforce mutual TLS only traffic, so you should see requests from sleep.legacy failing for both.***

```
for from in "foo" "bar" "legacy"; do for to in "foo" "bar"; do kubectl exec "$(kubectl get pod -l app=sleep -n ${from} -o jsonpath={.items..metadata.name})" -c sleep -n ${from} -- curl http://httpbin.${to}:8000/ip -s -o /dev/null -w "sleep.${from} to httpbin.${to}: %{http_code}\n"; done; done

```
## Reference:

- https://istio.io/latest/docs/tasks/security/authentication/mtls-migration/
