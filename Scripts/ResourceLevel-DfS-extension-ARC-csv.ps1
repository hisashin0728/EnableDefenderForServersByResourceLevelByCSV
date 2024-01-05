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
Start-Transcript ".\DfSPP_extensions_$filename.log"

# Generate Screen for checking
Write-Host "----------------------------------------------------------------------------"
Write-Host "[Private Preview] " -ForegroundColor Green  -NoNewline; Write-Host "This Powershell script is to check VM Extensions Resouce Level API (CSV bulk-mode)"
Write-Host "----------------------------------------------------------------------------"

# Start Loop
foreach ($line in $csv){
    # Write Date & Time
    Get-Date -UFormat "%Y/%m/%d %H:%M:%S"
    # Write Resource Group & Target VM
    Write-Host "Resource Group : " -NoNewline  -ForegroundColor DarkCyan; Write-Host $line.TargetResourceGroup
    Write-Host "Target VM : " -NoNewline  -ForegroundColor DarkCyan; Write-Host $line.TargetVM
    # Env for target RESTAPI endpoint
    $restUriWin = "https://management.azure.com/subscriptions/$($azContext.Subscription.Id)/resourceGroups/$($line.TargetResourceGroup)/providers/Microsoft.HybridCompute/machines/$($line.TargetVM)/extensions/MDE.Windows?api-version=2023-07-01"
    $restUriLinux = "https://management.azure.com/subscriptions/$($azContext.Subscription.Id)/resourceGroups/$($line.TargetResourceGroup)/providers/Microsoft.HybridCompute/machines/$($line.TargetVM)/extensions/MDE.Linux?api-version=2023-07-01"

    Try{
        # RESTAPI for MDE.Windows
        $aaa = Invoke-WebRequest -Uri $restUriWin -Headers $authHeader -Method Get
        $json1 = $aaa.Content | ConvertFrom-Json
        Write-Host "Defender for Servers : " -NoNewline -ForegroundColor Red; Write-Host $json1.name
    }
    catch{
        Try{
            # RESTAPI for MDE.Linux
            $bbb = Invoke-WebRequest -Uri $restUriLinux -Headers $authHeader -Method Get
            $json2 = $bbb.Content | ConvertFrom-Json
            Write-Host "Defender for Servers : " -NoNewline -ForegroundColor Red; Write-Host $json2.name
        }
        Catch{
            Write-Host "There are no MDE Extensions."
        }
    }
    Write-Host ""
}

# Stop Local Logging
Stop-Transcript