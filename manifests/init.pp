# Class: samba
#
# This module manages samba
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class samba {

  package { 'samba':
    ensure  => installed,
    notify  => Service['smb']
  }

  service { 'smb':
    ensure => 'running',
    enable => true,
    hasstatus => true
  }

}
