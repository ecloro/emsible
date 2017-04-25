Role Name
=========

mount-nfs

A role to mount an NFS mount point. This role:

1. Installs the NFS client RPMs
2. Configures idmapd.conf with a domain name
3. Creates a mountpoint
4. Mounts an NFS share to the mountpoint

Requirements
------------

None

Role Variables
--------------

mode: [**all**, nfs_install, create_mountpoint, mount]
* All will run all tasks in the role. nfs_install will only perform steps 1 and 2. create_mountpoint only creates a mountpoint and mount only performs step 4.

domain: [ **DOMAIN** ]
* domain is the domain that will be inserted to idmapd.conf as part of step 2. If not specified, it defaults to the environmental variable DOMAIN.


mount_point: [ **MOUNT_POINT** ]
* mount_point is the mount point that will be mounted as part of step 4. If not specified, it defaults to the environmental variable MOUNT_POINT
 
nfs_server: [ **NFS_SERVER** ]
* nfs_server is the IP or DNS address of the NFS server that will be mounted as part of step 4. If not specified, it defaults to the environmental variable NFS_SERVER

server_export: [ **SERVER_EXPORT** ]
* server_mount_point is the export on the NFS that will be mounted as part of step 4. If not specified, it defaults to the environmental variable SERVER_EXPORT
 

Dependencies
------------

None

Example Playbook
----------------

    - hosts: server
      user: root
      roles:
      - { role: mount-nfs,  mode: "all", domain: "skynet.local", mount_point: "/mnt/skynet", nfs_server: "10.20.254.6", server_export: "/skynet" }

License
-------

BSD

Author Information
------------------

Alex Hibbitt
