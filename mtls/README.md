# mTls:

## What is Mutual TLS?

## How it works?

## Demo Setup:

### Create two namespaces, foo and bar, and deploy httpbin and sleep with sidecars on both of them:
```
$ kubectl create ns foo
$ kubectl apply -f <(istioctl kube-inject -f samples/httpbin/httpbin.yaml) -n foo
$ kubectl apply -f <(istioctl kube-inject -f samples/sleep/sleep.yaml) -n foo
$ kubectl create ns bar
$ kubectl apply -f <(istioctl kube-inject -f samples/httpbin/httpbin.yaml) -n bar
$ kubectl apply -f <(istioctl kube-inject -f samples/sleep/sleep.yaml) -n bar
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
## Reference:

- https://istio.io/latest/docs/tasks/security/authentication/mtls-migration/
