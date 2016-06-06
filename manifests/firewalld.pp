#
# jenkins::firewalld class integrates with the firewalld module for
# opening the port to Jenkins automatically
#
class jenkins::firewalld {

  if $caller_module_name != $module_name {
    fail("Use of private class name ${name} by caller_module_name ${caller_module_name}, whereas module_name is ${module_name}.")
  }
  
  # if $::firewalld {
  if defined('::firewalld') {
    
    firewalld_port { 'Open port in the public zone for HTTP Jenkins web GUI':
      ensure   => present,
      zone     => 'public',
      port     => jenkins_port(),
      protocol => 'tcp',
    }
    if defined('::jenkins::slaveagentport') {
      firewalld_port { 'Open port in the public zone for Jenkins JNLP slaves':
        ensure   => present,
        zone     => 'public',
        port     => "${::jenkins::slaveagentport}",
        protocol => 'tcp',
      }
    }
    
    
  } else {
    fail("The firewalld class expects to see a defined '::firewalld'.")

  }
  
}
