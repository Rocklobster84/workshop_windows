#
# Cookbook:: windows
# Recipe:: security_bench
#
# Copyright:: 2022, Stephanie Thompson, All Rights Reserved.

# Allow log on locally set to administrators
windows_user_privilege 'Allow log on locally' do
  privilege 'SeInteractiveLogonRight'
  users          ['BUILTIN\Administrators']
  action         :set
end
