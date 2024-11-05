L1) Ensure 'Minimum password length' is set to '14 or more character(s)'


# Define the minimum required password length in characters
$minRequiredPasswordLength = 14

# Retrieve the current minimum password length policy using 'net accounts'
try {
    $passwordPolicy = net accounts | Select-String -Pattern "Minimum password length"
    $currentMinPasswordLength = [int]($passwordPolicy -replace "\D", "")  # Extracts only the number of characters
} catch {
    Write-Output "Error: Could not retrieve the Minimum Password Length setting. Ensure the script is run with administrative privileges."
    exit
}

# Check if the policy meets the benchmark requirements
if ($currentMinPasswordLength -ge $minRequiredPasswordLength) {
    Write-Output "The current Minimum Password Length is $currentMinPasswordLength characters, which meets the benchmark requirements."
} else {
    Write-Output "The current Minimum Password Length is set to $currentMinPasswordLength characters, which does not meet the benchmark requirement of $minRequiredPasswordLength or more characters."
    Write-Output "Recommendation: Set the Minimum Password Length to at least $minRequiredPasswordLength characters to meet the benchmark."
}
