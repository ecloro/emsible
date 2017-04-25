# Ansible Role: ntp-aam-setup

- Install/Setup NTP, with both AAM and public NTP servers
- Stops and Disables NTP service

## Role Variables

### Enable/Disable
`ntp_enabled`
+ Install/Setup: `true` (Default)
+ Stopped/Disable: `false` (Doesn't uninstall NTP)

### Timezone
`ntp_timezone`
default: Etc/UTC

### Public NTP Servers
`ntp_servers`
```bash
ntp_servers:
 - 0.pool.ntp.org iburst
 - 1.pool.ntp.org iburst
```

### AAM NTP Servers
`aam_ntp_servers`
*NOTE:* These also setup as step-tickers
```bash
aam_ntp_servers:
 - 172.30.6.11 iburst
 - 172.30.6.12 iburst
``` 

## Run in playbook
### Enable and setup NTP
This will install and setup NTP; setup London timezone with updated AAM NTP servers (they're also setup as step-tickers)
```bash
Vars:
  ntp_timezone: Europe/London
  aam_ntp_servers:
   - 10.20.30.4 iburst
   - 11.22.33.4 iburst
Roles:
  - role: ntp-aam-setup  
```

### Stop and disable NTP
```bash
roles:
  - { role: 'ntp-aam-setup', ntp_enabled: "false" } 
```
