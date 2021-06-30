FROM python:3.9-alpine
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
  && pip3 install \
    ansible==2.10.4 \
    cryptography==3.3.2 \
    f5-sdk==3.0.21 \
    deepdiff \
  && mkdir -p roles collections/ansible_collections \
  && ansible-galaxy install -fr requirements.yml \
  && ln -s veselahouba.f5_ansible roles/f5 \
  && git clone https://github.com/F5Networks/f5-ansible.git /tmp/f5-ansible/ \
  && mv /tmp/f5-ansible/ansible_collections/f5networks collections/ansible_collections/f5networks \
  && ln -s /opt/ansible/roles collections/ansible_collections/f5networks/f5_modules/roles \
  && apk del build-dependencies \
  && rm -rf /tmp/f5-ansible/ /var/cache/apk/*

# Temporary before https://github.com/F5Networks/f5-ansible/issues/2067 is fixed
COPY issue-2067/ /opt/ansible/collections/ansible_collections/f5networks/f5_modules/plugins/modules/
CMD ansible-playbook
