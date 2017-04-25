# Ansible Role: add-rpm-to-yum-repo

Copies rpm from local PATH to remote yumRepo server and reindex the remote yumRepo directory.

## Role Variables

### repository 
`repoDir` - yumRepo PATH (Include rpm architecture -> x86_64, i386, noarch and src).

### rpm File
Requires 3 variables (otherwise will fail..):
+ `rpmPath` - rpm base PATH (Include rpm architecture -> x86_64, i386, noarch and src)
+ `rpmFile` - rpm Filename

## playbook
Example playbook: test RPM is in `$HOME/tmp/rpmbuild/noarch`
```bash
add-rpm-to-yumRepo.yml
---
- name: test Add rpm to yum Repo
  hosts: "{{ remoteHost }}" 
  # -e "remoteHost=SERVER rpmFile=rpmFileName.rpm"
  roles:
    - { role: add-rpm-to-yum-repo, rpmPath: "/home/libelo/tmp/rpmbuild/noarch", repoDir: "/www/repo/rpmbuild/noarch" }
```
And run it:
```bash
$ cd /PATH/to/ansible

$ ansible-playbook -i stglab_inventory -e "remoteHost=rpmbuild-yumrepo rpmFile=aam-ndo-infr-2.2-3_1.el6.noarch.rpm" playbooks/tests/add-rpm-to-yumRepo.yml
```

