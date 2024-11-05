
Ensure 'Allow Administrator account lockout' is set to 'Enabled'

# Function to check the account lockout policy
function Check-AdminAccountLockout {
    # Define the temporary file path
    $seceditOutputPath = "$env:TEMP\secpol.cfg"

    # Export security policy settings to the temporary file
    secedit /export /cfg $seceditOutputPath /areas SECURITYPOLICY

    # Read the contents of the exported file
    $secpolContent = Get-Content $seceditOutputPath

    # Remove the temporary file
    Remove-Item $seceditOutputPath

    # Check if the account lockout policy is defined
    $adminLockoutSetting = $secpolContent | Select-String -Pattern "LockoutBadCount|ResetLockoutCount|LockoutDuration"

    if ($adminLockoutSetting) {
        $lockoutBadCount = ($adminLockoutSetting | Select-String "LockoutBadCount").ToString().Trim()
        $resetLockoutCount = ($adminLockoutSetting | Select-String "ResetLockoutCount").ToString().Trim()
        $lockoutDuration = ($adminLockoutSetting | Select-String "LockoutDuration").ToString().Trim()

        # Output the relevant settings
        Write-Output "Lockout Bad Count: $lockoutBadCount"
        Write-Output "Reset Lockout Count: $resetLockoutCount"
        Write-Output "Lockout Duration: $lockoutDuration"

        # Determine if the administrator account lockout is enabled
        if ($lockoutBadCount -match 'LockoutBadCount\s*=\s*0') {
            Write-Output "The 'Allow Administrator account lockout' policy is NOT enabled. It is recommended to enable this policy."
        } else {
            Write-Output "The 'Allow Administrator account lockout' policy is enabled."
        }
    } else {
        Write-Output "Could not determine the status of the 'Allow Administrator account lockout' policy."
    }
}

# Run the function to check the account lockout policy
Check-AdminAccountLockout
