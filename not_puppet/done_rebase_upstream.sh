#!/bin/bash

upstreamRemoteName='upstream' ;

main() {
  local hasRemote='' ;
  cd .. && {
    local bak=../Gemfile.lock.bak
    [[ ! -f $bak ]] || execute mv $bak ./Gemfile.lock ;
  }
}
execute() {
  local err='' ;
  "$@" || err=$? ;
  [[ $err -lt 1 ]] || { echo "ERROR: $err with {$@}." ; exit $err ; }
}

cd $(dirname $0) && main ;

#
