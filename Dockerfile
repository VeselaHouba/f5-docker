FROM python:3.8-alpine
COPY . /opt/ansible/
WORKDIR /opt/ansible/
RUN \
  apk --no-cache add \
    git \
    jq \
    bash \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev && \
  pip install \
    ansible==2.9.2 \
    f5-sdk==3.0.21 && \
  ansible-galaxy install -fr requirements.yml && \
  apk del \
    git \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev && \
  rm -rf /var/cache/apk/*
CMD ansible-playbook
