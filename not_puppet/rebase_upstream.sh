#!/bin/bash

upstreamRemoteName='upstream' ;

main() {
  local hasRemote='' ;
  cd .. && {
    if [[ -f Gemfile.lock ]] ; then
      local bak=../Gemfile.lock.bak
      [[ ! -f $bak ]] || execute rm $bak ;
      execute mv Gemfile.lock $bak ;
    fi ;
    execute git rebase "$upstreamRemoteName"/"master" ;
  }
}
execute() {
  local err='' ;
  "$@" || err=$? ;
  [[ $err -lt 1 ]] || { echo "ERROR: $err with {$@}." ; exit $err ; }
}

cd $(dirname $0) && main ;

#
