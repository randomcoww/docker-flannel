### Image build

```
mkdir -p build
export TMPDIR=$(pwd)/build

VERSION=v0.15.0

podman build \
  --build-arg VERSION=$VERSION \
  -f Dockerfile \
  -t ghcr.io/randomcoww/flannel:$VERSION
```

```
podman push ghcr.io/randomcoww/flannel:$VERSION
```