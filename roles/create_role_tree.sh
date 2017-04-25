#!/bin/bash

if [ -z "$1" ]; then echo "Usage: $0 roleName" 
else
  roleName="$1"
  mkdir -p roles/${roleName}/{tasks,handlers,templates,files,vars,defaults,meta}
  touch roles/${roleName}/{tasks,handlers,templates,files,vars,defaults,meta}/main.yml
fi

#
###.
