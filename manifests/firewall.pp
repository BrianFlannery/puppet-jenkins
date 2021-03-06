#
# jenkins::firewall class integrates with the puppetlabs-firewall module for
# opening the port to Jenkins automatically
#
class jenkins::firewall {

  if $caller_module_name != $module_name {
    fail("Use of private class name ${name} by caller_module_name ${caller_module_name}, whereas module_name is ${module_name}.")
  }

  firewall { '500 allow Jenkins inbound traffic':
    action => 'accept',
    state  => 'NEW',
    dport  => [jenkins_port()],
    proto  => 'tcp',
  }

}
