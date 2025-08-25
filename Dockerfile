# docker build -t miso-app:latest .
# docker run --rm -it -p 8080:80 miso-app:latest
# http://localhost:8080/

FROM juliendehos/miso-builder:latest AS builder
WORKDIR /root/miso-app
ADD . /root/miso-app
RUN nix develop .#wasm --experimental-features 'nix-command flakes' --command bash -c 'make'

# apache server
FROM httpd:2.4
COPY --from=builder /root/miso-app/public /usr/local/apache2/htdocs/

# nginx server
# FROM nginx
# COPY --from=builder /root/miso-app/public /usr/share/nginx/html

