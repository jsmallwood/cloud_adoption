# Orphaned Resources

## Disks
Resources    
| where type contains "microsoft.compute/disks"   
| extend diskState = tostring(properties.diskState)  
| where managedBy == ""  
    or diskState == 'Unattached'  
| project id, diskState, resourceGroup, location, subscriptionId


## NICS
resources  
| where type contains "microsoft.network/networkinterfaces"  
| where "{nicWithPrivateEndpoints}" !has id    
| where properties !has 'virtualmachine'  
| project id, resourceGroup, location, subscriptionId