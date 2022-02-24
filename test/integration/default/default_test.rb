# Chef InSpec test for recipe windows::default

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

# Test only the administrators group is allowed to login locally
describe security_policy do
  its('SeInteractiveLogonRight') { should eq ['S-1-5-32-544'] }
end
