#!/bin/bash

upstreamGitUrl='git@github.com:jenkinsci/puppet-jenkins' ;
upstreamGitUrlRegExp='github[.]com.jenkinsci/puppet[\-]jenkins' ;
upstreamRemoteName='upstream' ;

main() {
  local hasRemote='' ;
  cd .. && {
    hasRemote=`git remote -v | egrep "$upstreamGitUrlRegExp"` ;
    [[ $hasRemote ]] || execute git remote add "$upstreamRemoteName" "$upstreamGitUrl" ;
  }
}
execute() {
  local err='' ;
  "$@" || err=$? ;
  [[ $err -lt 1 ]] || { echo "ERROR: $err with {$@}." ; exit $err ; }
}

cd $(dirname $0) && main ;

#
