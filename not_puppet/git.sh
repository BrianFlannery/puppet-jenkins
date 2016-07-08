#!/bin/bash

upstreamGitUrl='git@github.com:jenkinsci/puppet-jenkins' ;
upstreamGitUrlRegExp='github[.]com.jenkinsci/puppet[\-]jenkins' ;
upstreamRemoteName='upstream' ;
upstream2() {
  local upstreamGitUrl='git@github.com:jhoblitt/puppet-jenkins' ;
  local upstreamGitUrlRegExp='github[.]com.jhoblitt/puppet[\-]jenkins' ;
  local upstreamRemoteName='upstream2' ;
  local hasRemote=`git remote -v | egrep "$upstreamGitUrlRegExp"` ;
  [[ $hasRemote ]] || execute git remote add "$upstreamRemoteName" "$upstreamGitUrl" ;
}

main() {
  local hasRemote='' ;
  cd .. && {
    hasRemote=`git remote -v | egrep "$upstreamGitUrlRegExp"` ;
    [[ $hasRemote ]] || execute git remote add "$upstreamRemoteName" "$upstreamGitUrl" ;
    upstream2 ;
  }
}
execute() {
  local err='' ;
  "$@" || err=$? ;
  [[ $err -lt 1 ]] || { echo "ERROR: $err with {$@}." ; exit $err ; }
}

cd $(dirname $0) && main ;

#
