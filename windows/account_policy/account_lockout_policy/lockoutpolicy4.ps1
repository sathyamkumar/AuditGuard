
# Define the required minimum reset time in minutes
$requiredResetTime = 15

# Function to retrieve the current Reset account lockout counter setting
function Get-ResetAccountLockoutCounter {
    try {
        $currentSetting = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ResetLockoutCount" -ErrorAction Stop
        return $currentSetting.ResetLockoutCount
    } catch {
        Write-Output "The Reset account lockout counter setting is not configured or accessible."
        return $null
    }
}

# Get the current setting
$currentResetTime = Get-ResetAccountLockoutCounter

# Assess the current setting
if ($currentResetTime -eq $null) {
    Write-Output "Audit Result: The 'Reset account lockout counter after' setting is not configured."
    Write-Output "Recommendation: Set the value to at least $requiredResetTime minutes to comply with the policy."
} elseif ($currentResetTime -ge $requiredResetTime) {
    Write-Output "Audit Result: The 'Reset account lockout counter after' is set to $currentResetTime minutes."
    Write-Output "Status: Compliant with the policy."
} else {
    Write-Output "Audit Result: The 'Reset account lockout counter after' is set to $currentResetTime minutes."
    Write-Output "Status: Non-compliant with the policy. Recommend setting it to at least $requiredResetTime minutes."
}



