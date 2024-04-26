# configures the Title, Department, Company, and Manager properties for the mail contact Allan Deyoung.
Set-Contact "Allan Deyoung" -Title Consultant -Department "Public Relations" -Company Fabrikam -Manager "Alex Wilber"
# sets the CustomAttribute1 property to a value of PartTime for all mail contacts and hides them from the organization's address book.
$Contacts = Get-MailContact -Resultsize unlimited
$Contacts | foreach {Set-MailContact -Identity $_ -CustomAttribute1 PartTime -HiddenFromAddressListsEnabled $true}
# sets the CustomAttribute15 property to a value of TemporaryEmployee for all mail contacts in the Public Relations department.
$PR = Get-Contact -ResultSize unlimited -Filter "Department -eq 'Public Relations'"
$PR | foreach {Set-MailContact -Identity $_ -CustomAttribute15 TemporaryEmployee}

