# == Class virtualbox::params
#
# This class is meant to be called from virtualbox
# It sets variables according to platform
#
class virtualbox::params {
  $version = '4.3'
  $manage_kernel = true
  $manage_package = true
  $manage_repo = true
  $package_ensure = present

  case $::osfamily {
    'Debian': {
      $package_name = 'virtualbox'
      $vboxdrv_dependencies = [
        'dkms',
        "linux-headers-${::kernelrelease}",
        'build-essential',
      ]
    }
    'RedHat': {
      $package_name = 'VirtualBox'
      $vboxdrv_dependencies = [
        'gcc',
        'make',
        'patch',
        'dkms',
        'kernel-headers',
        'kernel-devel',
        'binutils',
        'glibc-headers',
        'glibc-devel'
      ]
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
