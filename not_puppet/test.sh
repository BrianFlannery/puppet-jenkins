#!/bin/bash

[[ $SKIP_BEAKER ]]   || SKIP_BEAKER=true ;
[[ $BEAKER_UBUNTU ]] || BEAKER_UBUNTU=false ;

main() {
  cd .. && {
    execute bundle exec rake lint
    # execute bundle exec rake parallel_spec SPEC_OPTS='--format documentation --order random'
    execute bundle exec rake spec SPEC_OPTS='--format documentation --order random'
    export BEAKER_provision=yes ;
    export BEAKER_set="centos-7-docker" ;
    execute bundle exec rake acceptance ;
    if [[ false == $BEAKER_UBUNTU ]] ; then
      export BEAKER_set="ubuntu-14.04-docker" ;
      execute bundle exec rake acceptance ;
    fi ;
  }
}
execute() {
  local err='' ;
  "$@" || err=$? ;
  [[ $err -lt 1 ]] || { echo "ERROR '$err' with {$@}." ; exit $err ; }
}

cd $(dirname $0) && main ;

#
