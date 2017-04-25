# yumRepo-server Playbook

## Remote
```bash
cd /PATH/TO/ansible
ansible-playbook -i stglab_inventory -e "remoteHost=stglab2" playbooks/yumRepo/yumRepo-server-rpmbuild.yml
```
## Local
```bash
ansible-playbook -e "remoteHost=localhost" yumRepo-server.yml
```

## Test in container
Skip reboot, when kernel has an update - yumRepo-server role is setup with restart, when running os-update role.
Setting system_update_restart to false should override it:
```bash
ansible-playbook -e "remoteHost=localhost system_update_restart=false" yumRepo-server.yml
```

## os-update
yumRepo-Server role is setup to use os-update role, with reboot enabled.
when there are updates, the relevant handlers will be triggered and the machine will reboot at the end of the playbook.
From the example below:
```bash
[...skip...]

TASK [os-update : Update system] ***********************************************
changed: [stglab5]

[...skip...]

RUNNING HANDLER [os-update : Restart Machine] **********************************
ok: [stglab5]

RUNNING HANDLER [os-update : Wait for Restart] *********************************
ok: [stglab5 -> localhost]

[...skip...]
```

## NOTE about EFS
Using EFS in AWS is potentially the best solution for ever expanding yum-repository.
However, since it's mounted using NFS and sqlite has an issue creating DBs in NFS, createrepo is currently failing
to create the index files in repodata/ Directory.
As a result, I've reverted to use an attached volume, configured in LVM and setup with xfs (preferred FS in AWS/CentOS).


## Setup local-repo for tests
The below is an example of a local yum-repo file, enables us to query a local yumRepo - please update the relevant PATH.
```bash
# vi /etc/yum.repos.d/local.repo 

[local-noarch]
name=Local Repo - noarch
enabled=0
baseurl=file:///www/repo/rpmbuild/noarch
```
And query the repository by running (update rpmName to relevant):
```bash
# yum list available --disablerepo=* --enablerepo=local-noarch
---
# yum --disablerepo=* --enablerepo=local-noarch --showduplicates list aam-ndo-infr
```


## Example: playbook output on new Machine
```bash
$ ansible-playbook -i stglab_inventory -e "remoteHost=stglab5" playbooks/yumRepo/yumRepo-server-rpmbuild.yml

PLAY [Install yum Repository Server - rpmbuild repo] ***************************

TASK [setup] *******************************************************************
ok: [stglab5]

TASK [install-repo.aam.local-yum-repo : Setup os_version] **********************
ok: [stglab5]

TASK [install-repo.aam.local-yum-repo : Add repository file] *******************
changed: [stglab5]

TASK [install-repo.aam.local-yum-repo : Add CentOS GPG key] ********************
ok: [stglab5]

TASK [install-repo.aam.local-yum-repo : Import EPEL GPG key] *******************
ok: [stglab5]

TASK [install-repo.aam.local-yum-repo : Import AAM GPG key] ********************
ok: [stglab5]

TASK [install-repo.aam.local-yum-repo : stat artsalliancemedia repo file] ******
ok: [stglab5]

TASK [install-repo.aam.local-yum-repo : Rename artsalliancemedia.repo if exist] 
changed: [stglab5]

TASK [install-epel-scl-repos : fail] *******************************************
skipping: [stglab5]

TASK [install-epel-scl-repos : Install RHEL/CentOS Add-On yum repositories] ****
changed: [stglab5] => (item={u'state': u'latest', u'name': u'epel-release'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'centos-release-scl'})

TASK [mount-efs : Install nfs-common (Debian)] *********************************
skipping: [stglab5]

TASK [mount-efs : Install nfs-utils (RedHat)] **********************************
ok: [stglab5]

TASK [mount-efs : Get mount source URL with availability zone] *****************
ok: [stglab5]

TASK [mount-efs : Create directories for the mounts] ***************************
changed: [stglab5] => (item={u'group': u'root', u'region': u'eu-west-1', u'mode': u'0644', u'owner': u'root', u'path': u'/efs', u'filesystem_id': u'fs-58b17591'})

TASK [mount-efs : Mount paths] *************************************************
changed: [stglab5] => (item={u'group': u'root', u'region': u'eu-west-1', u'mode': u'0644', u'owner': u'root', u'path': u'/efs', u'filesystem_id': u'fs-58b17591'})

TASK [os-install-addons-pkgs : fail] *******************************************
skipping: [stglab5]

TASK [os-install-addons-pkgs : Install Addon Packages.] ************************
changed: [stglab5] => (item={u'state': u'latest', u'name': u'yum-utils'})
ok: [stglab5] => (item={u'state': u'latest', u'name': u'which'})
ok: [stglab5] => (item={u'state': u'latest', u'name': u'man'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'telnet'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'curl'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'wget'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'sysstat'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'vim'})
ok: [stglab5] => (item={u'state': u'latest', u'name': u'vim-enhanced'})
ok: [stglab5] => (item={u'state': u'latest', u'name': u'vim-common'})
ok: [stglab5] => (item={u'state': u'latest', u'name': u'lsof'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'bind-utils'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'parted'})
ok: [stglab5] => (item={u'state': u'latest', u'name': u'tmpwatch'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'lftp'})
ok: [stglab5] => (item={u'state': u'latest', u'name': u'ncftp'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'ftp'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'ntp'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'openssh-clients'})
ok: [stglab5] => (item={u'state': u'latest', u'name': u'nc'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'cifs-utils'})
ok: [stglab5] => (item={u'state': u'latest', u'name': u'mailx'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'procps'})
ok: [stglab5] => (item={u'state': u'latest', u'name': u'cloud-init'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'cloud-utils'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'util-linux-ng'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'tar'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'dos2unix'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'git'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'sudo'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'python-pip'})
changed: [stglab5] => (item={u'state': u'latest', u'name': u'ansible'})

TASK [os-update : fail] ********************************************************
skipping: [stglab5]

TASK [os-update : Update system] ***********************************************
changed: [stglab5]

TASK [nginx-server : Include OS-specific variables.] ***************************
ok: [stglab5]

TASK [nginx-server : Define nginx_user.] ***************************************
ok: [stglab5]

TASK [nginx-server : Enable nginx repo.] ***************************************
changed: [stglab5]

TASK [nginx-server : Ensure nginx is installed.] *******************************
changed: [stglab5]

TASK [nginx-server : Add PPA for Nginx.] ***************************************
skipping: [stglab5]

TASK [nginx-server : Ensure nginx will reinstall if the PPA was just added.] ***
skipping: [stglab5]

TASK [nginx-server : Update apt cache.] ****************************************
skipping: [stglab5]

TASK [nginx-server : Ensure nginx is installed.] *******************************
skipping: [stglab5]

TASK [nginx-server : Update pkg cache.] ****************************************
skipping: [stglab5]

TASK [nginx-server : Ensure nginx is installed.] *******************************
skipping: [stglab5]

TASK [nginx-server : Create logs directory.] ***********************************
skipping: [stglab5]

TASK [nginx-server : Remove default nginx vhost config file (if configured).] **
skipping: [stglab5]

TASK [nginx-server : Ensure nginx_vhost_path exists.] **************************
ok: [stglab5]

TASK [nginx-server : Add managed vhost config file (if any vhosts are configured).] ***
skipping: [stglab5]

TASK [nginx-server : Remove managed vhost config file (if no vhosts are configured).] ***
ok: [stglab5]

TASK [nginx-server : Copy nginx configuration in place.] ***********************
changed: [stglab5]

TASK [nginx-server : Ensure nginx is started and enabled to start at boot.] ****
changed: [stglab5]

TASK [yumRepo-server : Install yumRepo related packages] ***********************
changed: [stglab5] => (item={u'state': u'latest', u'name': u'createrepo'})
ok: [stglab5] => (item={u'state': u'latest', u'name': u'yum-utils'})
ok: [stglab5] => (item={u'state': u'latest', u'name': u'rsync'})

TASK [yumRepo-server : Ensure repoDir exist] ***********************************
ok: [stglab5]

TASK [yumRepo-server : Add index file to DocumentRoot] *************************
ok: [stglab5]

TASK [yumRepo-server : Remove nginx default.conf file] *************************
changed: [stglab5]

TASK [yumRepo-server : Add default yumRepo server config file in nginx] ********
changed: [stglab5]

TASK [yumRepo-server : Create yumRepo directory structure] *********************
ok: [stglab5] => (item={u'path0': u'rpmbuild', u'path1': u'x86_64'})
ok: [stglab5] => (item={u'path0': u'rpmbuild', u'path1': u'noarch'})
ok: [stglab5] => (item={u'path0': u'rpmbuild', u'path1': u'i386'})

RUNNING HANDLER [os-update : Restart Machine] **********************************
ok: [stglab5]

RUNNING HANDLER [os-update : Wait for Restart] *********************************
ok: [stglab5 -> localhost]

RUNNING HANDLER [nginx-server : reload nginx] **********************************
changed: [stglab5]

PLAY RECAP *********************************************************************
stglab5                    : ok=32   changed=15   unreachable=0    failed=0   
```

