# Ansible Role: add-host-to-etcHosts

Add host to /etc/hosts on localhost

## Source
https://github.com/teampants/ansible-local-hosts


## Variables (defaults)

### which /etc/hosts to update, local or remote?
The role can run on both local and/or remote hosts
local -> rootHost running the playbook 
remote -> host the playbook is running on

The default is to add host/s to remote host:
```bash 
localUpdate: no
remoteUpdate: yes
```
This setup supports local, remote and both. 


### multiple hosts
Add multiple hosts by using the `with_items` setup.
Default will add localhosts's IP address and Hostname to its own `/etc/hosts`
i.e. useful to run on new machine (run without vars).
```bash
add_hosts:
  - ip: "{{ ansible_default_ipv4.address }}"
    name: "{{ inventory_hostname }}"
```


## Example Playbook
Add yumRepo-server hostname and IP address to rpmbuild-server (playbook is running from the rpmbuild-server -> is rootHost).
```bash
---
- name: test add-host-to-inventory
  hosts: "{{ remoteHost }}"
  become: yes
  become_user: root
  vars:
    localUpdate: yes
    remoteUpdate: no
    add_hosts:
      - ip: 172.28.17.40
        name: yumRepo-server
  roles:
    - role: add-host-to-etcHosts

- name: test added host
  hosts: yumRepo-server
  gather_facts: no
  tasks:
    - name: ping all hosts
      ping:
```
### Run
ping is just a test.. the below assumes 
+ ssh-keys are already setup (using setup in the relevant inventory file).
+ localuser has sudo-without-pass on local machine (otherwise preReq package and update /etc/hosts will fail)

```bash
---Local:
$ ansible-playbook -i stglab_inventory -e "remoteHost=localhost" playbooks/tests/add-host-to-etcHosts.yml
---Remote/Both:
$ ansible-playbook -i stglab_inventory -e "remoteHost=stglab3" playbooks/tests/add-host-to-etcHosts.yml
```

