# installs graph to current user only
Install-Module Microsoft.Graph -Scope CurrentUser
# imports the IAM module
Import-Module Microsoft.Graph.Identity.DirectoryManagement
# opens browser for authentication, scope is the permission, here we have given sudo rights
Connect-MgGraph -Scopes 'User.ReadWrite.All'
