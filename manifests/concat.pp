#
# Class iptables::concat
#
# This class builds the iptables rule file using RIPienaar's concat module
# We build it using several fragments.
# Being the sequence of lines important we define these boundaries:
# 01 - General header
# Note that the iptables::rule define
# inserts (by default) its rules with priority 50.
#
class iptables::concat {

  include iptables
  include concat::setup

  concat { $iptables::config_file:
    mode    => $iptables::config_file_mode,
    owner   => $iptables::config_file_owner,
    group   => $iptables::config_file_group,
    notify  => Service['iptables'],
  }


  # The File Header. With Puppet comment
  concat::fragment{ 'iptables_header':
    target  => $iptables::config_file,
    content => "# File Managed by Puppet\n",
    order   => 01,
    notify  => Service['iptables'],
  }

  # The FILTER table header with the default policies
  concat::fragment{ 'iptables_filter_header':
    target  => $iptables::config_file,
    content => template('iptables/concat/filter_header'),
    order   => 05,
    notify  => Service['iptables'],
  }

  # The input chain header with sane defaults
  concat::fragment{ 'iptables_filter_input_header':
    target  => $iptables::config_file,
    content => template('iptables/concat/filter_input_header'),
    order   => 10,
    notify  => Service['iptables'],
  }

  # The input chain footer with logging and block_policy
  concat::fragment{ 'iptables_filter_input_footer':
    target  => $iptables::config_file,
    content => template('iptables/concat/filter_input_footer'),
    order   => 19,
    notify  => Service['iptables'],
  }

  # The output chain header with sane defaults
  #concat::fragment{ 'iptables_filter_output_header':
  #  target  => $iptables::config_file,
  #  content => template('iptables/concat/filter_output_header'),
  #  order   => 20,
  #  notify  => Service['iptables'],
  #  noop    => true,
  #}

  # The output chain footer with logging and block_policy
  #concat::fragment{ 'iptables_filter_output_footer':
  #  target  => $iptables::config_file,
  #  content => template('iptables/concat/filter_output_footer'),
  #  order   => 29,
  #  notify  => Service['iptables'],
  #  noop    => true,
  #}

  # The forward chain header with sane defaults
  #concat::fragment{ 'iptables_filter_forward_header':
  #  target  => $iptables::config_file,
  #  content => template('iptables/concat/filter_forward_header'),
  #  order   => 30,
  #  notify  => Service['iptables'],
  #  noop    => true,
  #}

  # The forward chain footer with logging and block_policy
  #concat::fragment{ 'iptables_filter_forward_footer':
  #  target  => $iptables::config_file,
  #  content => template('iptables/concat/filter_forward_footer'),
  #  order   => 39,
  #  notify  => Service['iptables'],
  #  noop    => true,
  #}

  # The FILTER table footer (COMMIT)
  concat::fragment{ 'iptables_filter_footer':
    target  => $iptables::config_file,
    content => template('iptables/concat/filter_footer'),
    order   => 40,
    notify  => Service['iptables'],
  }



  # The NAT table header with the default policies
  concat::fragment{ 'iptables_nat_header':
    target  => $iptables::config_file,
    content => template('iptables/concat/nat_header'),
    order   => 45,
    notify  => Service['iptables'],
  }

  # The NAT table footer (COMMIT)
  concat::fragment{ 'iptables_nat_footer':
    target  => $iptables::config_file,
    content => template('iptables/concat/nat_footer'),
    order   => 60,
    notify  => Service['iptables'],
  }



  # The MANGLE table header with the default policies
  concat::fragment{ 'iptables_mangle_header':
    target  => $iptables::config_file,
    content => template('iptables/concat/mangle_header'),
    order   => 65,
    notify  => Service['iptables'],
  }

  # The MANGLE table footer (COMMIT)
  concat::fragment{ 'iptables_mangle_footer':
    target  => $iptables::config_file,
    content => template('iptables/concat/mangle_footer'),
    order   => 80,
    notify  => Service['iptables'],
  }


}
