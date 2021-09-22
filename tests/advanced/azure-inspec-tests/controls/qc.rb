# copyright: 2018, The Authors

# Test values

resource_group1 = 'rg-test-mysql-advanced-resources'

describe azure_mysql_server(resource_group: resource_group1, name: 'test-mysql-advanced') do
  it { should exist }
  its('sku.name') { should include 'GP_Gen5_2' }
  its('properties.version') { should cmp '5.7' }
  its('properties.administratorLogin') { should cmp 'test_admin' }
  its('properties.storageProfile.storageMB') { should cmp 5120 }
  its('properties.storageProfile.geoRedundantBackup') { should cmp "Enabled" }
  its('properties.storageProfile.backupRetentionDays') { should cmp 7 }
  its('properties.storageProfile.storageAutogrow') { should cmp "Enabled" }
  its('properties.infrastructureEncryption') { should cmp "Enabled" }
  its('properties.sslEnforcement') { should cmp "Enabled" }
  its('properties.minimalTlsVersion') { should cmp "TLS1_2" }
  its('properties.publicNetworkAccess') { should cmp "Disabled" }
end

describe azure_mysql_database(resource_group: resource_group1, server_name: 'test-mysql-advanced', name: 'testdb1' ) do
  it { should exist }
  its('properties.charset') { should cmp 'utf8' }
  its('properties.collation') { should cmp 'utf8_unicode_ci' }
end

describe azure_mysql_database(resource_group: resource_group1, server_name: 'test-mysql-advanced', name: 'testdb2' ) do
  it { should exist }
  its('properties.charset') { should cmp 'utf8' }
  its('properties.collation') { should cmp 'utf8_unicode_ci' }
end
