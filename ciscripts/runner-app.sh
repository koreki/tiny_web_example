#!/bin/bash
#
#
set -e
set -o pipefail
set -u
set -x

eval "$(
  ./create-centos.sh
  )"
trap "mussel instance destroy \"${instance_id}\"" ERR

eval "$(./instance-get-ipaddr.sh "${instance_id}")"

{
  ./instance-wait4ssh.sh  "${instance_id}"
  ./instance-exec.sh      "${instance_id}" < ./provision-app.sh
}

echo instance_id="${instance_id}"
