#!/usr/bin/env bash
IMG=f5-docker
docker run \
  --rm \
  -ti \
  -v `pwd`/environments:/opt/ansible/environments \
  -v `pwd`/files:/opt/ansible/files \
  -v `pwd`/.vault_pass.txt:/opt/ansible/.vault_pass.txt \
  -v `pwd`/ansible.cfg:/opt/ansible/ansible.cfg \
  -v `pwd`/playbooks:/opt/ansible/playbooks \
  -v `pwd`/f5_partial_deploy.yml:/opt/ansible/f5_partial_deploy.yml \
  -e 'DISPLAY_SKIPPED_HOSTS' \
  -e 'ANSIBLE_DISPLAY_OK_HOSTS' \
  "${IMG}" \
  bash -c "ansible-playbook $*"
