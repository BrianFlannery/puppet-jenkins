#!/bin/bash

# # # For running tests on a local workstation.  See .travis.yml
# # # USAGE:
# bash not_puppet/test.sh
# PARALLEL_SPEC=false bash not_puppet/test.sh # to run tests in serial (to see accurate code coverage)
# SKIP_BEAKER=false bash not_puppet/test.sh # to run beaker tests
# # # 

[[ $SKIP_BEAKER ]]   || SKIP_BEAKER=true ;
[[ $BEAKER_UBUNTU ]] || BEAKER_UBUNTU=false ;
[[ $PARALLEL_SPEC ]] || PARALLEL_SPEC=false ;

main() {
  cd .. && {
    if [[ skip_other != $SKIP_BEAKER ]] ; then
      execute bundle exec rake lint
      if [[ true == $PARALLEL_SPEC ]] ; then
        execute bundle exec rake parallel_spec SPEC_OPTS='--format documentation --order random'
      else
        execute bundle exec rake spec SPEC_OPTS='--format documentation --order random'
      fi ;
    fi ;
    if [[ true != $SKIP_BEAKER ]] ; then
      export BEAKER_provision=yes ;
      export BEAKER_set="centos-7-docker" ;
      execute bundle exec rake acceptance ;
      if [[ true == $BEAKER_UBUNTU ]] ; then
        export BEAKER_set="ubuntu-14.04-docker" ;
        execute bundle exec rake acceptance ;
      fi ;
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
