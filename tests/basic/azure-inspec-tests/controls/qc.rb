# copyright: 2018, The Authors

# Test values

resource_group1 = 'rg-test-mysql-basic-resources'

describe azure_mysql_server(resource_group: resource_group1, name: 'test-mysql-basic') do
  it              { should exist }
  its('sku.name') { should include 'GP_Gen5_2' }
  its('properties.version') { should cmp '5.7' }
  its('properties.administratorLogin') { should cmp 'test_admin' }
  its('properties.storageProfile.storageMB') { should cmp 5120 }
end