# Chef InSpec test for recipe windows::default

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

# Test only the administrators group is allowed to login locally
describe security_policy do
  its('SeInteractiveLogonRight') { should eq ['S-1-5-32-544'] }
end

# Only administrators and remote desktop users should be able to login remotely
describe security_policy do
  its('SeRemoteInteractiveLogonRight') { should eq ['S-1-5-32-544', 'S-1-5-32-555'] }
end

#  The 'Accounts:Administrator account status' should exist and be disabled
describe users.where { uid =~ /S\-1\-5\-21\-\d+\-\d+\-\d+\-500/ } do
  it { should exist }
end
describe users.where { uid =~ /S\-1\-5\-21\-\d+\-\d+\-\d+\-500/ } do
  it { should be_disabled }
end

#  The 'Interactive logon: do not require ctrl+alt+del' setting should exist and be disabled
describe registry_key('HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System') do
  it { should have_property 'DisableCAD' }
end
describe registry_key('HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System') do
  its('DisableCAD') { should cmp == 0 }
end

#  The 'Enable Windows NTP client' setting should be exist and be enabled
describe registry_key('HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient') do
  it { should have_property 'Enabled' }
end
describe registry_key('HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient') do
  its('Enabled') { should cmp == 1 }
end

#  The 'Enable Windows NTP server' setting should exist and be disabled
describe registry_key('HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer') do
  it { should have_property 'Enabled' }
end
describe registry_key('HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer') do
  its('Enabled') { should cmp == 0 }
end