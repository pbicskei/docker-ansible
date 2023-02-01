FROM alpine

ARG TARGETPLATFORM
ENV ANSIBLE_VERSION 2.10.1
RUN case ${TARGETPLATFORM} in \
         "linux/amd64")  TINI_ARCH=amd64  ;; \
         "linux/arm64")  TINI_ARCH=arm64  ;; \
         "linux/arm/v7") TINI_ARCH=arm  ;; \
         "linux/386")    TINI_ARCH=386   ;; \
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
