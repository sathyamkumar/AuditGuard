# Set the Account Lockout Threshold to 5 invalid attempts
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LockoutBadCount" -Value 5

# Optional: Set the lockout duration and reset duration (in minutes)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LockoutDuration" -Value 15  # duration before unlock
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ResetLockoutCount" -Value 15  # time before reset

# To verify the changes
Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LockoutBadCount"
Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LockoutDuration"
Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ResetLockoutCount"




# Audit Account Lockout Settings
$lockoutBadCount = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LockoutBadCount" -ErrorAction SilentlyContinue
$lockoutDuration = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LockoutDuration" -ErrorAction SilentlyContinue
$resetLockoutCount = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ResetLockoutCount" -ErrorAction SilentlyContinue

# Display the results
Write-Host "Current Account Lockout Settings:"
Write-Host "Invalid Logon Attempts Allowed: $($lockoutBadCount.LockoutBadCount)"
Write-Host "Lockout Duration (minutes): $($lockoutDuration.LockoutDuration)"
Write-Host "Reset Lockout Count Duration (minutes): $($resetLockoutCount.ResetLockoutCount)"



