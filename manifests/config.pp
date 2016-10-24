# Class: config
#
# This module manages samba config
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class samba::config {
  file { 'config':
    ensure  => file,
    content => template('samba/smb.conf.erb'),
    path    => '/etc/samba/smb.conf',
  }
}
