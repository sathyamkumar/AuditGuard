# Registry path and value name
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters"
$valueName = "MaximumPasswordAge"

try {
    # Check if the registry key and value exist
    $value = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction Stop

    # Check if the 'MaximumPasswordAge' is 24 or more
    if ($value.$valueName -ge 24) {
        Write-Host "CIS Benchmark satisfied: 'Enforce password history' is set to 24 or more passwords."
    } else {
        Write-Host "CIS Benchmark NOT satisfied: 'Enforce password history' is set to $($value.$valueName) passwords."
    }
} catch {
    Write-Host "Registry key or value not found or permission denied. Ensure you run the script with administrative privileges."
}


