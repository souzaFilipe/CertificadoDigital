# Define the certificate thumbprint to search for
$certThumbprint = "ThumbPrintDoCertificado"

# Get the current logged-in user
$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

# Function to write logs
function Write-Log {
    param (
        [string]$message
    )
    $logMessage = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $message"
    Write-Output $logMessage
}

# Search for the certificate in the current user's store
$cert = Get-ChildItem -Path Cert:\CurrentUser\My | Where-Object { $_.Thumbprint -eq $certThumbprint }

if ($cert) {
    Write-Log "Certificate found for user $currentUser."

    try {
        # Attempt to remove the certificate
        Remove-Item -Path "Cert:\CurrentUser\My\$($cert.Thumbprint)" -ErrorAction Stop
        Write-Log "Certificate with thumbprint $certThumbprint was successfully removed."
    } catch {
        Write-Log "Failed to remove the certificate. Error: $_"
    }
} else {
    Write-Log "Certificate with thumbprint $certThumbprint not found for user $currentUser."
}

# Example of running the script and capturing the log in a file
$logFilePath = "C:\Path\To\Log\certificate_removal_log.txt"
$logContent = Invoke-Command -ScriptBlock {
    . C:\Path\To\This\Script.ps1
}
$logContent | Out-File -FilePath $logFilePath -Append
