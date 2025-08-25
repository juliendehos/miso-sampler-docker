
## Dockerfile-builder

Docker image for building miso apps.

To be built and deployed on dockerhub, then used for building/testing any miso
app.

```
docker build -f Dockerfile-builder -t juliendehos/miso-builder:latest .
docker push juliendehos/miso-builder:latest
```


## Dockerfile

Docker image for building and testing a miso app locally.

```
docker build -t miso-app:latest .
docker run --rm -it -p 8080:8080 miso-app:latest
```


## .github/workflows/main.yml

In Github Actions, just use the builder image:


```
jobs:
  build:
    runs-on: juliendehos/miso-builder:latest
```

and run the build command:

```
        run: nix develop .#wasm --command bash -c "make"
```

