[![Build Status](https://travis-ci.org/while-true-do/ansible-role-system-update.svg?branch=master)](https://travis-ci.org/while-true-do/ansible-role-system-update)

# Ansible Role: system-update
| A role to update the system and reboot it.

## Installation

Galaxy Link: <https://galaxy.ansible.com/while-true-do/system-update>

```
ansible-galaxy install while-true-do.system-update
```

Github Link: <https://github.com/while-true-do/ansible-role-system-update>

```
git clone https://github.com/while-true-do/ansible-role-system-update while-true-do.system-update
```

## Requirements

None.

## Dependencies

None.

## Role Variables

```
# defaults/main.yml
system_update_restart: "true"
```

## Example Playbook

Simple Example:

```
- hosts: servers
  roles:
    - { role: while-true-do.system-update }
```

## License

This work is licensed under a [BSD License](https://opensource.org/licenses/BSD-3-Clause).

## Contribute / Bugs

**bug reports:** <https://github.com/while-true-do/ansible-role-system-update/issues>

**contributers:** <https://github.com/while-true-do/ansible-role-system-update/graphs/contributors>

## Author Information

**blog:** <https://blog.while-true-do.org>

**github:** <https://github.com/daniel-wtd>

**contact:** [mail@while-true-do.org](mailto:mail@while-true-do.org)
