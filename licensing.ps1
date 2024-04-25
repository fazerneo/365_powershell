# PowerShell requires the Organization.Read.All permission scope to read the licenses available in the tenant.
Connect-MgGraph -Scopes User.ReadWrite.All, Organization.Read.All
# To find the unlicensed accounts in your organization
Get-MgUser -Filter 'assignedLicenses/$count eq 0' -ConsistencyLevel eventual -CountVariable unlicensedUserCount -All
# To find the unlicensed synchronized users in your organization
Get-MgUser -Filter 'assignedLicenses/$count eq 0 and OnPremisesSyncEnabled eq true' -ConsistencyLevel eventual -CountVariable unlicensedUserCount -All -Select UserPrincipalName
# To find accounts that don't have a UsageLocation value
Get-MgUser -Select Id,DisplayName,Mail,UserPrincipalName,UsageLocation,UserType | where { $_.UsageLocation -eq $null -and $_.UserType -eq 'Member' }
# To set the UsageLocation value on an account
$userUPN="<user sign-in name (UPN)>" # Eg: john@contoso.com
$userLoc="<ISO 3166-1 alpha-2 country code>" # Eg: US, FR, UK, IN

Update-MgUser -UserId $userUPN -UsageLocation $userLoc
# Assigning License
Set-MgUserLicense -UserId $userUPN -AddLicenses @{SkuId = "<SkuId>"} -RemoveLicenses @()
# Assigning a SPE_E5 license
$e5Sku = Get-MgSubscribedSku -All | Where SkuPartNumber -eq 'SPE_E5'
Set-MgUserLicense -UserId "belindan@litwareinc.com" -AddLicenses @{SkuId = $e5Sku.SkuId} -RemoveLicenses @()
# Assigning SPE_E5 and EMSPREMIUM License
$e5Sku = Get-MgSubscribedSku -All | Where SkuPartNumber -eq 'SPE_E5'
$e5EmsSku = Get-MgSubscribedSku -All | Where SkuPartNumber -eq 'EMSPREMIUM'
$addLicenses = @(
@{SkuId = $e5Sku.SkuId},
@{SkuId = $e5EmsSku.SkuId}
)

Set-MgUserLicense -UserId "belinda@litwareinc.com" -AddLicenses $addLicenses -RemoveLicenses @()

$e5Sku = Get-MgSubscribedSku -All | Where SkuPartNumber -eq 'SPE_E5'
$disabledPlans = $e5Sku.ServicePlans | Where ServicePlanName -in ("LOCKBOX_ENTERPRISE", "MICROSOFTBOOKINGS") | Select -ExpandProperty ServicePlanId
# assigns SPE_E5 (Microsoft 365 E5) with the MICROSOFTBOOKINGS (Microsoft Bookings) and LOCKBOX_ENTERPRISE (Customer Lockbox) services turned off
$addLicenses = @(
@{
SkuId = $e5Sku.SkuId
DisabledPlans = $disabledPlans
}
)

Set-MgUserLicense -UserId "belinda@litwareinc.com" -AddLicenses $addLicenses -RemoveLicenses @()

