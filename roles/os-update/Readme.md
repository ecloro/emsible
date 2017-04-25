# Ansible Role: os-update

By default, os-update Role doesn't reboot the system.

Examples: 
In relevant playbooks or as dependency in other roles, in `meta/main.yml`

## Run role without reboot (Default)
```bash
roles:
  - role: os-update
```

## Run playbook with reboot
Example: when running the playbook inside a container.
```bash
roles:
  - { role: os-update, system_update_restart: "true" }
```

