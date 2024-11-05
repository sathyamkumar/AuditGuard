(L1) Ensure 'Maximum password age' is set to '365 or fewer days, but not 0' :-
# Define the acceptable maximum password age (in days)
$maxAllowedPasswordAge = 365

# Retrieve the current maximum password age policy
try {
    $currentMaxPasswordAge = (Get-LocalUser | Where-Object { $_.Name -eq 'Administrator' }).PasswordExpires
} catch {
    Write-Output "Error: Could not retrieve the Maximum Password Age setting. Ensure the script is run with administrative privileges."
    exit
}

if ($null -eq $currentMaxPasswordAge) {
    Write-Output "Maximum Password Age policy is not set (or is set to 0), which does not meet the benchmark requirements."
    Write-Output "Recommendation: Set the Maximum Password Age to a value between 1 and $maxAllowedPasswordAge days."
} elseif ($currentMaxPasswordAge -le $maxAllowedPasswordAge -and $currentMaxPasswordAge -ne 0) {
    Write-Output "The current Maximum Password Age is $currentMaxPasswordAge days, which meets the benchmark requirements."
} else {
    Write-Output "The current Maximum Password Age is $currentMaxPasswordAge days, which exceeds the maximum allowed threshold of $maxAllowedPasswordAge days."
    Write-Output "Recommendation: Set the Maximum Password Age to a value of $maxAllowedPasswordAge days or fewer."
}






