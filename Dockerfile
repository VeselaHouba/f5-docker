FROM python:3.8-alpine
COPY . /opt/ansible/
WORKDIR /opt/ansible/
RUN \
  apk add \
    --no-cache \
    jq \
    bash
RUN \
  apk add \
    --no-cache \
    --virtual build-dependencies \
    git \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev \
  && pip install \
    ansible==2.9.2 \
    cryptography==3.3.2 \
    f5-sdk==3.0.21 \
    deepdiff \
  && ansible-galaxy install -fr requirements.yml \
  && apk del build-dependencies \
  && rm -rf /var/cache/apk/*
CMD ansible-playbook
