#
# jenkins::firewall_wrapper class picks between firewall and firewalld
#
class jenkins::firewall_wrapper {

  # if $::firewalld {
  if defined('::firewalld') {
    include jenkins::firewalld
  } else {
    include jenkins::firewall
  }
}
