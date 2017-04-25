Role Name
=========

disable-default-repos

A Role to manage enabled repositories on a host

Requirements
------------

None

Role Variables
--------------

disable_repos: [**all**,default,epel,artsalliancemedia]

Pass the above variable with one of the options in the list to the role in order to disable your choice of repository. Defaults to all.

Dependencies
------------

none

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      remote_user: root
      roles:
         - { role: disable-defualt-repos, disable_repos: "all" }

License
-------

BSD

Author Information
------------------

Lilly Ibelo & Alex Hibbitt
