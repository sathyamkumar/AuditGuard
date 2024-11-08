(L2) Ensure 'Bluetooth Support Service (bthserv)' is set to 'Disabled'

# Define the service name
$serviceName = "bthserv"

# Get the service status
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

# Check if the service exists
if ($service) {
    # Output the current status of the service
    if ($service.Status -eq 'Stopped' -and $service.StartType -eq 'Disabled') {
        Write-Output "The 'Bluetooth Support Service (bthserv)' is DISABLED."
    } elseif ($service.Status -eq 'Running') {
        Write-Output "The 'Bluetooth Support Service (bthserv)' is ENABLED. It is recommended to disable this service."
    } else {
        Write-Output "The 'Bluetooth Support Service (bthserv)' is STOPPED but not set to DISABLED. Please check the service configuration."
    }
} else {
    Write-Output "The 'Bluetooth Support Service (bthserv)' does not exist on this system."
}

# Optional: To disable the service if it's running or set to automatic
if ($service.Status -eq 'Running' -or $service.StartType -ne 'Disabled') {
    Stop-Service -Name $serviceName -Force
    Set-Service -Name $serviceName -StartupType Disabled
    Write-Output "The 'Bluetooth Support Service (bthserv)' has been DISABLED."
}
