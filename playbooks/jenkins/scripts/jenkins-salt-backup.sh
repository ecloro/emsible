#!/bin/bash

#
# Script to run Salt backup for Jenkins-Prod from Ansible PlayBook
# https://artsalliancemedia.atlassian.net/wiki/display/NDO/Jenkins+Maintenance%3A+Backup+Configuration#
#

if [ -z "${1}" ] || [ -z "${2}" ]; then echo "Usage: $0 PATH-to-Repo-Dir sshKey"; exit; fi

gitLab_repo_home="${1}"
sshKey="${2}"
misc_repo="misc"
salt_repo="salt-states"

## functions:
__git-check-update () 
{
## Check if git Repo is up2date..
git fetch origin
#git log HEAD..origin/master --oneline
git rev-list HEAD...origin/master --count
}
#
__update-local-repo ()
{
## $1: git repo (full path)
cd ${1}
if [[ "$(__git-check-update)" != 0 ]] ; then
  git pull
  #git merge origin/master
fi
}
#
__git-update-repo () {
# Script to update repository in GitLab
if [ -z "$1" ] && [ -z "$2" ]; then echo "Usage: ${FUNCNAME[0]} REPO_NAME COMMIT_MSG"
else
 repo_name="$1"
 commit_msg="$2"
 repo_dir="${gitLab_repo_home}/${repo_name}"
 export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
 echo -e "\n\n ${repo_name}: Updating Gitlab ($(date +%F-%H%M))"
 cd $repo_dir
 git submodule init
 git submodule update
 git add --all .
 git commit -m "${commit_msg}"
 git push origin master
fi
}
##

## Update local repos
__update-local-repo ${gitLab_repo_home}/${misc_repo}
__update-local-repo ${gitLab_repo_home}/${salt_repo}

## Run backup
cd ${gitLab_repo_home}/${misc_repo}
jenkins/master-to-salt --identity ${sshKey} --repo ${gitLab_repo_home}/${salt_repo} --sync

## Update salt repo
cd ${gitLab_repo_home}
__git-update-repo ${salt_repo} "[Jenkins] Backup/Sync Configuration"

#
### end.
