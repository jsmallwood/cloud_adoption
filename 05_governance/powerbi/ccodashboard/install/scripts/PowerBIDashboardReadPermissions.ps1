<#
.SYNOPSIS
This script creates a new AzureRmRole and assign it to all the subscriptions for a given Azure Account with enough permissions 
.DESCRIPTION
This script creates a new AzureRmRole and assign it to all the subscriptions for a given Azure Account with enough permissions
The new AzureRmRole name is defined in $RoleName variable and can be customized
. SECURITY
The script calls Login-AzureRmAccount to require authentication before it can start generating/updating Azure Advisor recommendations.
.EXAMPLE
PowerBIDashboardReadPermissionsRole.ps1

List roles
(Get-AzureRmRoleDefinition | FT Name, Description).count

List custom Roles
Get-AzureRmRoleDefinition | ?{$_.IsCustom -eq $true} | FT Name, IsCustom 


#delete custom role
#Get-AzureRmRoleDefinition "Continuous Optimization Power BI Dashboard Reader" | Remove-AzureRmRoleDefinition


actions

Listing Resource Providers Operations
Get-AzureRMProviderOperation "Microsoft.Advisor/*" | FT OperationName, Operation , Description -AutoSize
Get-AzureRMProviderOperation "Microsoft.Security/*" | FT OperationName, Operation , Description -AutoSize
Get-AzureRMProviderOperation "Microsoft.ResourceHealth/*" | FT OperationName, Operation , Description -AutoSize

#>

Login-AzAccount

$RoleName = "Continuous Optimization Power BI Dashboard Reader"
Get-AzRoleDefinition $RoleName | Remove-AzRoleDefinition


$SubsList = Get-AzSubscription

$role = Get-AzRoleDefinition "Contributor"
$role.Id = $null
$role.Name = $RoleName
$role.Description = $RoleName
$role.Actions.Clear()

#Global reader permissions
$role.Actions.Add("*/read")

#Azure Advisor Resource Provider Permissions
$role.Actions.Add("Microsoft.Advisor/generateRecommendations/action")
$role.Actions.Add("Microsoft.Advisor/Recommendations/Read")

#Azure Security Resource Provider Permissions
$role.Actions.Add("Microsoft.Security/tasks/read")
$role.Actions.Add("Microsoft.Security/Alerts/Read")
$role.Actions.Add("Microsoft.Security/Policies/Read")
$role.Actions.Add("Microsoft.Security/locations/alerts/read")

#Azure ResourceHealth Resource Provider Permissions
$role.Actions.Add("Microsoft.Resourcehealth/AvailabilityStatuses/read")
$role.Actions.Add("Microsoft.Resourcehealth/AvailabilityStatuses/current/read")


$role.AssignableScopes.Clear()

if(!(Get-AzManagementGroup))
{
    # Assign the role to all subscriptions
    foreach($Sub in $SubsList)
    {
        $temp = $Sub.SubscriptionID
        $role.AssignableScopes.Add("/subscriptions/$temp")
    }
} else {
    # Assign the role to the Root Management Group
    $mgid = (Get-AzManagementGroup | Where {$_.DisplayName -eq 'Tenant Root Group'}).Id
    $role.AssignableScopes.Add("$($mgid)")
}

New-AzRoleDefinition -Role $role