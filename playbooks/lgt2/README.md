# Setup LGT2 Staging Servers in VRTX

Servers:
+ `lgt2-app`: LGT2 App Server
+ `lgt2-db` : LGT2 Database Server

## Setup VMs in the VRTX
There are 2 ways of setting up the Staging environment in VRTX for LGT2.

*Pre-Requirement:* you must be a minimum admin and able to login to the VRTX Env: https://vc-06:9443.

### From existing lgt2XXX-template
+ Login to the VRTX.

+ Under Lifeguard-Ticketing Directory we have two relevant templates: `lgt2-app-template` and `lgt2-db-template`

+ right-click the relevant template -> New VM from This Template.
Always name the server lgt2-app or lgt2-db (pick the relevant) -> the current setup relays on these 2 DNS names.
Pick Lifeguard-Ticketing Directory, whichever host (preferably one that doesn't have any issues) and otherwise defaults.

+ Run `bootstrap` -> option1 and rename the server to the relevant. Once complete, reboot.

+ Internal DNS update might take up to 10 minutes to update.


### Manual Installation
+ Login to the VRTX.

+ Create a VM from CentOS6 Template.

+ Turn the VM on and click on the console to open in another tab.

+ Login with default root and run `bootstrap`-> option1 to rename the server and reboot.

+ Once back, run `bootstrap` -> option2 and reboot once the option completes (might take a while).

+ On local, go to the ansible repository (make sure it's synced with latest) and run the relevant playbook, as details below.


## Check Connectivity
```bash
ansible -i lgt2_inventory --private-key=/home/lilly/.ssh/ndo-vrtex all -m ping
```

## Run the playbooks
Go To the root directory of ansible git repository: `cd $HOME/SOMEWHERE/ansible`

*NOTE:* Update the ssh-key PATH below.


### lgt2-db
```bash
ansible-playbook -i lgt2_inventory --private-key=/PATH/TO/ndo-vrtex playbooks/lgt2/lgt2db.yml
```

### lgt2-app
```bash
ansible-playbook -i lgt2_inventory --private-key=/PATH/TO/ndo-vrtex playbooks/lgt2/lgt2app.yml
```



