
(L2) Ensure 'Turn off Help Experience Improvement Program' is set to 'Enabled' :-

# Get the current user's SID
$userSID = (Get-LocalUser -Name $env:USERNAME).SID

# Define the full registry path
$registryPath = "Registry::HKEY_USERS\$userSID\Software\Policies\Microsoft\Assistance\Client\1.0"
$valueName = "NoImplicitFeedback"

# Check if the registry key exists
if (Test-Path $registryPath) {
    # Get the value of NoImplicitFeedback
    $value = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

    # Determine if the setting is configured
    if ($value -ne $null) {
        if ($value.NoImplicitFeedback -eq 1) {
            Write-Output "The 'Turn off Help Experience Improvement Program' policy is enabled."
        } else {
            Write-Output "The 'Turn off Help Experience Improvement Program' policy is NOT enabled."
            # Set the NoImplicitFeedback value to 1 (Enabled)
            New-ItemProperty -Path $registryPath -Name $valueName -Value 1 -PropertyType DWord -Force
            Write-Output "The policy has now been enabled."
        }
    } else {
        Write-Output "The 'Turn off Help Experience Improvement Program' policy is NOT configured."
        # Set the NoImplicitFeedback value to 1 (Enabled)
        New-ItemProperty -Path $registryPath -Name $valueName -Value 1 -PropertyType DWord -Force
        Write-Output "The policy has now been enabled."
    }
} else {
    Write-Output "The registry path does not exist, creating the path and applying the policy."

    # Create the registry path
    New-Item -Path $registryPath -Force

    # Set the NoImplicitFeedback value to 1 (Enabled)
    New-ItemProperty -Path $registryPath -Name $valueName -Value 1 -PropertyType DWord -Force
    Write-Output "The 'Turn off Help Experience Improvement Program' policy has been applied."
}

# Final verification of the policy
$value = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

if ($value -ne $null -and $value.NoImplicitFeedback -eq 1) {
    Write-Output "The 'Turn off Help Experience Improvement Program' policy is confirmed as enabled."
} else {
    Write-Output "The 'Turn off Help Experience Improvement Program' policy could not be confirmed."
}
