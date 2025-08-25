# docker build -t miso-app:latest .
# docker run --rm -it -p 8080:8080 miso-app:latest

FROM juliendehos/miso-builder:latest
WORKDIR /root/miso-app
ADD . /root/miso-app
RUN nix develop .#wasm --experimental-features 'nix-command flakes' --command bash -c 'make'
CMD ["http-server public/"]

