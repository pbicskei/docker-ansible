FROM alpine:3.18

ARG TARGETPLATFORM
ENV ANSIBLE_VERSION 2.10.1
RUN case ${TARGETPLATFORM} in \
         "linux/amd64")  TINI_ARCH=amd64  ;; \
         "linux/arm64")  TINI_ARCH=arm64  ;; \
    esac && \
    apk add --update wget ca-certificates python3 python3-dev build-base libffi-dev openssl-dev && \
    wget -q -O /get-pip.py https://bootstrap.pypa.io/get-pip.py && \
    python3 /get-pip.py && \
    pip3 install ansible==${ANSIBLE_VERSION} && \
    apk del --purge wget ca-certificates python3-dev build-base libffi-dev openssl-dev && \
    rm -rf /var/cache/apk/* /get-pip.py

VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT ["ansible-playbook"]

CMD ["--help"]
