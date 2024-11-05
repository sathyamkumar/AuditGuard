(L1) Ensure 'Minimum password age' is set to '1 or more day(s)':-

# Define the minimum required password age in days
$minRequiredPasswordAge = 1

# Retrieve the current minimum password age policy using 'net accounts'
try {
    $passwordPolicy = net accounts | Select-String -Pattern "Minimum password age"
    $currentMinPasswordAge = [int]($passwordPolicy -replace "\D", "")  # Extracts only the number of days
} catch {
    Write-Output "Error: Could not retrieve the Minimum Password Age setting. Ensure the script is run with administrative privileges."
    exit
}

# Check if the policy meets the benchmark requirements
if ($currentMinPasswordAge -ge $minRequiredPasswordAge) {
    Write-Output "The current Minimum Password Age is $currentMinPasswordAge days, which meets the benchmark requirements."
} else {
    Write-Output "The current Minimum Password Age is set to $currentMinPasswordAge days, which does not meet the benchmark requirement of $minRequiredPasswordAge or more day(s)."
    Write-Output "Recommendation: Set the Minimum Password Age to at least $minRequiredPasswordAge day(s) to meet the benchmark."
}

