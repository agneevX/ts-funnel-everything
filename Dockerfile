FROM ghcr.io/linuxserver/baseimage-alpine:arm64v8-3.19

RUN git clone https://github.com/tailscale-dev/docker-mod \
    && cp -r docker-mod/root / \
    && sed -i 's#http://localhost#http://${TAILSCALE_SERVE_CONTAINER}#g' /etc/s6-overlay/s6-rc.d/svc-tailscale-up/run \
    && rm -rfv docker-mod/

ENV TAILSCALE_FUNNEL=1 \
    TAILSCALE_STATE_DIR=/config

VOLUME /config
