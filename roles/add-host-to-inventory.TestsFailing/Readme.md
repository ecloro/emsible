# Ansible Role: add-host-to-inventory

__*!!!-Tests Are Currently Failing-!!!*__

Add host to ansible-playbook in-memory/current inventory

Additional details see: http://docs.ansible.com/ansible/add_host_module.html


## Variables (defaults)
```bash
host_IP: "{{ ansible_default_ipv4.address }}"
host_Hostname: "{{ inventory_hostname }}"
host_Port: 22
```

## Example Playbook
```bash
- name: test add-host-to-inventory
  hosts: localhosts
  vars:
    add_hosts:
      - ip: 172.28.17.40
        name: yumRepo-server
        port: 22
        group: tmpGroup
  roles:
    - role: add-host-to-inventory

- name: test added host
  hosts: tmpHosts
  tasks:
    - name: ping all hosts
      ping:
```
