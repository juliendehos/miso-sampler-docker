
## Dockerfile-builder

Docker image for building miso apps.

To be built and deployed on dockerhub, then used for building/testing any miso
app.

```
docker build -f Dockerfile-builder -t juliendehos/miso-builder:latest .
docker push juliendehos/miso-builder:latest
```

(see also the miso-docker-builder repo)


## Dockerfile

Docker image for building and testing a miso app locally.

```
docker build -t miso-app:latest .
docker run --rm -it -p 8080:80 miso-app:latest
```

Then go to `http://localhost:8080`

You can also push/deploy the `miso-app:latest` image.


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

