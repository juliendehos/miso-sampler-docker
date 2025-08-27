
# Build/deploy a miso app into a docker image 

## Using Dockerfile

### Dockerfile-builder

Docker image for building miso apps.

To be built and deployed on dockerhub, then used for building/testing any miso
app.

```
docker build -f Dockerfile-builder -t juliendehos/miso-builder:latest .
docker push juliendehos/miso-builder:latest
```

(see also the miso-docker-builder repo)


### Dockerfile

Docker image for building and testing a miso app locally.

```
docker build -t miso-app:latest .
docker run --rm -it -p 8080:80 miso-app:latest
```

Then go to `http://localhost:8080`

You can also push/deploy the `miso-app:latest` image.

## Using Nix's docker tools

The miso app should be built using the usual Nix flake shell. `app.nix`
puts the `public` folder into a package. Then `docker.nix` puts this
package into a docker image, and runs a http server:

```
nix develop .#wasm --command bash -c "make"
nix-build docker.nix
docker load < result
docker run --rm -it -p 3000:3000 app-server:latest
```

