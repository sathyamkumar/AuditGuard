
(L1) Ensure 'Turn off toast notifications on the lock screen' is set to 'Enabled'


# Define the registry path and value name
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
$valueName = "NoToastApplicationNotification"

# Check if the registry key exists
if (Test-Path $registryPath) {
    # Get the value of the NoToastApplicationNotification
    $value = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

    # Determine if the setting is configured
    if ($value -ne $null) {
        if ($value.NoToastApplicationNotification -eq 1) {
            Write-Output "The 'Turn off toast notifications on the lock screen' policy is enabled."
        } else {
            Write-Output "The 'Turn off toast notifications on the lock screen' policy is NOT enabled."
        }
    } else {
        Write-Output "The 'Turn off toast notifications on the lock screen' policy is NOT configured."
    }
} else {
    Write-Output "The registry path does not exist, meaning the policy has not been applied."
}
