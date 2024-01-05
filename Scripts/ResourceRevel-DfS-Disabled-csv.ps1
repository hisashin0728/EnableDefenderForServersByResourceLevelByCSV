# Log in first with Connect-AzAccount if not using Cloud Shell
# Import CSV from local Folder
$csv = Import-CSV .\target.csv

# Env for Azure
$azContext = Get-AzContext
$azProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($azProfile)
$token = $profileClient.AcquireAccessToken($azContext.Subscription.TenantId)
$authHeader = @{
    'Content-Type'='application/json'
    'Authorization'='Bearer ' + $token.AccessToken
}

# Start Local Logging
$filename = Get-Date -Format "yyyyMMdd-HHmmss"
Start-Transcript ".\DfSPP_Disabled_$filename.log"

# Generate Screen for checking
Write-Host "----------------------------------------------------------------------------"
Write-Host "[Private Preview] " -ForegroundColor Blue  -NoNewline; Write-Host "This Powershell script is trying to disable Defender for Servers P1 as Resource Level (CSV bulk-mode)"
Write-Host "----------------------------------------------------------------------------"

# Start Loop
foreach ($line in $csv){
    # Write Date & Time
    Get-Date -UFormat "%Y/%m/%d %H:%M:%S"
    # Write Resource Group & Target VM
    Write-Host "Resource Group : " -NoNewline  -ForegroundColor DarkCyan; Write-Host $line.TargetResourceGroup
    Write-Host "Target VM : " -NoNewline  -ForegroundColor DarkCyan; Write-Host $line.TargetVM
    # Env for target RESTAPI endpoint
    $restUri = "https://management.azure.com/subscriptions/$($azContext.Subscription.Id)/resourceGroups/$($line.TargetResourceGroup)/providers/Microsoft.Compute/virtualMachines/$($line.TargetVM)/providers/Microsoft.Security/pricings/virtualMachines?api-version=2023-08-01-preview"

    # Put RESTAPI
    $w = Invoke-WebRequest -Uri $restUri -InFile disable.json -Headers $authHeader -Method Put
    Write-Host "Result : " -ForegroundColor DarkCyan; $w.StatusDescription
    Write-Host "Contents : " -ForegroundColor DarkCyan; $w.Content | ConvertFrom-Json | ConvertTo-Json -Depth 100
    Write-Host ""
}

# Stop Local Logging
Stop-Transcript