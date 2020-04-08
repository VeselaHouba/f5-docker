f5-docker
=========
Docker image built around ansible role for managing F5 boxes.

F5 role: https://gitlab.m-cloud.cz/ansible/f5

# Quickstart

Pull latest docker image

```
docker pull jmcloud/f5-docker
```

## Example structure
Create your local ansible configuration. Folowing basic structure is expected/tested.


```
.
|-- .vault_pass.txt
|-- ansible.cfg
|-- f5_partial_deploy.yml
|-- requirements.yml
|-- environments
|   |-- env01
|   |   |-- group_vars
|   |   |   |-- all
|   |   |   |   |-- default.yml
|   |   |   |   |-- f5_asm.yml
|   |   |   |   |-- f5_certificates.yml
|   |   |   |   |-- f5_irules_datagroups.yml
|   |   |   |   |-- f5_monitors.yml
|   |   |   |   |-- f5_profiles.yml
|   |   |   |   `-- f5_provider.yml
|   |   |   |-- lab
|   |   |   |   |-- f5_irules.yml
|   |   |   |   |-- f5_ltm.yml
|   |   |   |   `-- vault.yml
|   |   |   |-- preprod
|   |   |   |   |-- f5_irules.yml
|   |   |   |   |-- f5_ltm.yml
|   |   |   |   `-- vault.yml
|   |   |   `-- prod
|   |   |       |-- f5_irules.yml
|   |   |       |-- f5_ltm.yml
|   |   |       `-- vault.yml
|   |   `-- hosts
|-- files
|   |-- ASM_policies
|   |   `-- policy01.xml
|   |-- certificates
|   |   |-- cert01.crt
|   |   `-- cert01.key
|   |-- data_groups
|   |   `-- data_group01.txt
|   |-- iApps
|   |   `-- iapp01.tmpl
|   `-- iRules
|       `-- irule01.tcl
`-- playbooks
    |-- lab.yml
    |-- preprod.yml
    `-- prod.yml
```

Run image with your config - extensive example below.
Script is included in image as `/opt/ansible/runme-docker.sh`

```
IMG=jmcloud/f5-docker
docker run \
  --rm \
  -ti \
  -v `pwd`/environments:/opt/ansible/environments \
  -v `pwd`/files:/opt/ansible/files \
  -v `pwd`/.vault_pass.txt:/opt/ansible/.vault_pass.txt \
  -v `pwd`/ansible.cfg:/opt/ansible/ansible.cfg \
  -v `pwd`/playbooks:/opt/ansible/playbooks \
  -v `pwd`/f5_partial_deploy.yml:/opt/ansible/f5_partial_deploy.yml \
  "${IMG}" \
  bash -c "ansible-playbook playbook/lab.yml"
```

# Related projects
https://gitlab.m-cloud.cz/ansible/f5

License
-------

BSD

Author Information
------------------
Jan Michalek (michalek_at_m-cloud.cz)
