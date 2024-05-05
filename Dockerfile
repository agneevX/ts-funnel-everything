FROM lsiobase/alpine:edge as base

ENV DOCKER_MODS=ghcr.io/tailscale-dev/docker-mod:main \
    TAILSCALE_FUNNEL=1 \
    TAILSCALE_STATE_DIR=/config

RUN sed -i 's#http://localhost#http://${TAILSCALE_SERVE_CONTAINER}#g' /etc/s6-overlay/s6-rc.d/svc-tailscale-up/run 

FROM scratch as main

COPY --from=base /root /

VOLUME /config

ENTRYPOINT /init
