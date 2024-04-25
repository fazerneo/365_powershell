# Set password to a variable
$PasswordProfile = @{ Password = 'user password' }
# create user with the password from variable
New-MgUser -UserPrincipalName username@domainname –DisplayName 'Firstname Lastname' –GivenName 'Firstname' –Surname 'Lastname' -PasswordProfile $PasswordProfile -AccountEnabled -MailNickName 'email alias'
# Bulk create users
Import-Csv -Path <Input CSV File Path and Name> | foreach {New-MgUser -DisplayName $_.DisplayName -GivenName $_.FirstName -Surname $_.LastName -UserPrincipalName $_.UserPrincipalName -UsageLocation $_.UsageLocation -LicenseAssignmentStates $_.AccountSkuId -PasswordProfile $_.Password} | Export-Csv -Path <Output CSV File Path and Name>
