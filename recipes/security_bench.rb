#
# Cookbook:: windows
# Recipe:: security_bench
#
# Copyright:: 2022, Stephanie Thompson, All Rights Reserved.

# Allow log on locally set to administrators
windows_user_privilege 'Allow log on locally' do
  privilege 'SeInteractiveLogonRight'
  users ['BUILTIN\Administrators']
  action :set
end

windows_user_privilege 'Allow log on through Remote Desktop Services' do
  privilege 'SeRemoteInteractiveLogonRight'
  users ['BUILTIN\Administrators', 'BUILTIN\Remote Desktop Users']
  action :set
end

windows_security_policy 'EnableAdminAccount' do
  secvalue '0'
  action :set
end

registry_key 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' do
  values [{
    name: 'DisableCAD',
    type: :dword,
    data: 0,
  }]
  action :create
end

registry_key 'HKLM\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpClient' do
  values [{
    name: 'Enabled',
    type: :dword,
    data: 1,
  }]
  recursive: true
  action :create
end

registry_key 'HKLM\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpServer' do
  values [{
    name: 'Enabled',
    type: :dword,
    data: 0,
  }]
  action :create
end
