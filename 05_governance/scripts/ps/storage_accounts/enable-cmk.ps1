[string] $subscriptionId = "9333ff49-e576-423a-982f-545d2eb5ed65"

[int] $keyExpirationInMonths = ""
[int] $keyExpirationInYears = ""

[string] $storageAccountName = "azsk20210107203508"
[string] $storageAccountResourceGroupName = "AzSKRG"

[string] $keyVaultName = "kv-az-eastus2"
[string] $keyVaultResourceGroupName = "rg-global-management"


<#
if(($subscriptionName -ne $null) -or ($subscriptionId -ne $null))
{
    Get-AzSubscription | % {
        Get-AzSubscription -SubscriptionId $_.-SubscriptionId | Set-AzContext




    }
}
#>

function Get-KeyVault
{
    param(
        $ResourceGroupName,
        $VaultName
    )

    $objKeyVault = Get-AzKeyVault -ResourceGroupName $ResourceGroupName -VaultName $VaultName

    Return $objKeyVault

}

function Get-KeyVaults
{
    begin{
        $objKeyVaults = Get-AzKeyVault
    }
    process {
        For($i=0; $i -le $objKeyVaults.Count; $i++)
        {
            Switch -Regex ($objKeyVaults[$i].VaultName)
            {
                #'\bkv-az\b' { Write-Host $objKeyVaults[$i].VaultName }
                #'\bkv-az\b' { $objKeyVault = Get-AzKeyVault -ResourceGroupName $objKeyVaults[$i].ResourceGroupName -VaultName $objKeyVaults[$i].VaultName }
                '^\bkv-az\b' { $objKeyVault = Get-KeyVault -ResourceGroupName $objKeyVaults[$i].ResourceGroupName -VaultName $objKeyVaults[$i].VaultName }

            }

        }
    }
    end{
        Return $objKeyVault
    }
}

function New-Key
{
    param(
        [string] $VaultName,
        [string] $KeyName,
        [string] $Destination = 'Software',
        [string] $keyExpirationLength,
        [int] $keyExpirationDuration,
        [string] $keyExpirationDate,
        [string[]] $KeyOperations,
        [object] $Tags

    )

    begin{
        Switch ($keyExpirationLength)
        {
            "Months": { $Expires = (Get-Date).AddMonths($keyExpirationDuration).ToUniversalTime() }
            "Years": { $Expires = (Get-Date).AddYears($keyExpirationDuration).ToUniversalTime() }
            "Weeks": { $Expires = (Get-Date).AddWeeks($keyExpirationDuration).ToUniversalTime() }
            "Days": { $Expires = (Get-Date).AddDays($keyExpirationDuration).ToUniversalTime() }
        }
        $NotBefore = (Get-Date).ToUniversalTime()
    }
    process {


    }
    end {


    }

}




Get-KeyVaults

$objKeyVault






New-AzStorageEncryptionScope -ResourceGroupName "myresourcegroup" -AccountName "mystorageaccount" -EncryptionScopeName testscope -KeyvaultEncryption -KeyUri "https://keyvalutname.vault.azure.net:443/keys/keyname/34a0ba563b4243d9a0ef2b1d3c0c7d57"





Get-AzSubscription -SubscriptionId $subscriptionId | Set-AzContext

$objStorageAccounts = Get-AzStorageAccount

$objStorageAccounts | % {
    Get-AzStorageEncryptionScope -ResourceGroupName $_.ResourceGroupName -StorageAccountName $_.Name

    Update-AzStorageAccountEncryptionScope `
        -ResourceGroupName $_.ResourceGroupName `
        -StorageAccountName $_.Name `
        -EncryptionScopeName $encryptionScopeName `
        -KeyvaultEncryption `
        -KeyUri $keyURI

}

#$objStorageAccount = Get-AzStorageAccount -ResourceGroupName $storageAccountResourceGroupName -Name $storageAccountName

#$objStorageEncryptionScope = Get-AzStorageEncryptionScope -ResourceGroupName


$KeyOperations = 'decrypt', 'verify'

$KeyOperations.GetType()