FROM alpine:latest AS builder

RUN set -ex \
    && apk update \
    && apk add wget \
    && mkdir /ss/ \
    && wget https://github.com/gfw-report/shadowsocks-rust/releases/download/v0.0.1-beta/shadowsocks-v1.15.0-alpha.9.x86_64-unknown-linux-musl.tar.xz \
    && tar -xvf shadowsocks-v1.15.0-alpha.9.x86_64-unknown-linux-musl.tar.xz -C /ss/

FROM alpine:latest AS dest

RUN set -ex \
    && apk update \
    && apk add tzdata ca-certificates \
    && rm -rf /var/cache/apk/*


COPY --from=builder /ss/ssserver /usr/bin/
COPY --from=builder /ss/sslocal /usr/bin/

ENTRYPOINT [ "ssserver" ]
