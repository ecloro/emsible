# aam-producer Installation/update

## Installation
```bash
ansible-playbook -i stglab_inventory aam-producer-r-inst.yml --extra-vars="remoteHost=stglab2"
ansible-playbook -i stglab_inventory aam-producer-r-updt.yml --extra-vars="remoteHost=stglab2"
```

## Update
```bash
ansible-playbook -i stglab_inventory aam-producer-sa-r-inst.yml --extra-vars="remoteHost=stglab3"
ansible-playbook -i stglab_inventory aam-producer-sa-r-updt.yml --extra-vars="remoteHost=stglab3"
```
