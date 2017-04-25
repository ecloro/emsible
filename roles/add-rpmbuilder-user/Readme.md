# Ansible Role: add-rpmbuilder-user

Create rpmbuilder user, with wheel permissions and adds its ssh keys.

_*Notes:*_ 
+ This is a fixed role, due to specific ssh-key setup
+ Role structure already supports adding multiple users (currently with the same wheel setup)

## Dependencies
Ansible Role: sudo-setup

__**Note:**__ 
If this role is used outside of ansible gitRepo structure, make sure to include both role-directories:
+ `add-rpmbuilder-user`
+ `sudo-setup`


## Example in Playbook
```bash
roles:
  - role: add-rpmbuilder-user
```
