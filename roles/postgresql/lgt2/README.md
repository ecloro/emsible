
### Run Manually:
```bash
ansible-playbook --extra-vars 'role=ANXS.postgresql varFile=./roles/ANXS.postgresql/lgt2/lgt2_vars.yml' test_role.yml
```

### Run within a playbook:
```bash
vars_files:
  - ./roles/ANXS.postgresql/lgt2/lgt2_vars.yml
roles:
  - { role: ANXS.postgresql }
```

