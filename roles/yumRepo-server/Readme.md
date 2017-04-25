# Ansible Role: yumRepo-server

Configures a yum Repository Server, using nginx as web-server.

## Vars
Override the default by setting up in Vars:
```bash
repoDir: "/PATH/to/Dir"
repoName: "repoName"
localUser: "localUser"
```

## Example: rpmbuild yumRepo
_*Note:*_ 
The below playbook isn't using EFS as its yumRepo directory since createrepo using sqlite, which isn't supported on NFS.
The assumption now is that `repoDir` already exist and setup on the server; in this case: `/www/repo` is a separate volume,
configured on LVM and formated as XFS.

```bash
yumRepo-server-rpmbuild.yml 
---
- name: Install yum Repository Server - rpmbuild repo
  hosts: "{{ remoteHost }}" ### -e "remoteHost=HOSTNAME"
  #-------
  vars:
    ## Role: yumRepo-server
    repoDir: "/www/repo"
    repoName: rpmbuild
    localUser: rpmbuilder

    ## Role: mount-efs
    #efsDir: {{ repoDir }}  ### [NDO-1083] createrepo isn't working on NFS (sqlite fails to create-db).
    efsDir: "/efs"
    aws_efs_paths:
      - { path: "{{ efsDir }}", owner: "root", group: "root", mode: "0644", region: "eu-west-1", filesystem_id: "fs-58b17591"}
  #-------
  roles:
    - { role: install-repo.aam.local-yum-repo }
    - { role: install-epel-scl-repos }
    - { role: mount-efs }
    - { role: 'yumRepo-server', when: ansible_os_family == 'RedHat' }
  #-------
```
