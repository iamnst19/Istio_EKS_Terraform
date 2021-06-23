# Download Istio

1. Go to the Istio release page to download the installation file for your OS, or download and extract the latest release automatically (Linux or macOS):

```
$ curl -L https://istio.io/downloadIstio | sh 
```
The command above downloads the latest release (numerically) of Istio. You can pass variables on the command line to download a specific version or to override the processor architecture. For example, to download Istio 1.6.8 for the x86_64 architecture, run:

```
$ curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.6.8 TARGET_ARCH=x86_64 sh -
```

2. Move to the Istio package directory. For example, if the package is istio-1.10.1:

```
$ cd istio-1.10.1
```
The installation directory contains:

- Sample applications in samples/
- The istioctl client binary in the bin/ directory.

3. Add the istioctl client to your path (Linux or macOS):

```
$ export PATH=$PWD/bin:$PATH
```

## Reference:

https://istio.io/latest/docs/setup/getting-started/#download