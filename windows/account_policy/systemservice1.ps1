
 (L2) Ensure 'Bluetooth Audio Gateway Service (BTAGService)' is set to 'Disabled'


# Define the service name
$serviceName = "BTAGService"

# Get the service status
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

# Check if the service exists
if ($service) {
    # Output the current status of the service
    if ($service.Status -eq 'Stopped' -and $service.StartType -eq 'Disabled') {
        Write-Output "The 'Bluetooth Audio Gateway Service (BTAGService)' is DISABLED."
    } elseif ($service.Status -eq 'Running') {
        Write-Output "The 'Bluetooth Audio Gateway Service (BTAGService)' is ENABLED. It is recommended to disable this service."
    } else {
        Write-Output "The 'Bluetooth Audio Gateway Service (BTAGService)' is STOPPED but not set to DISABLED. Please check the service configuration."
    }
} else {
    Write-Output "The 'Bluetooth Audio Gateway Service (BTAGService)' does not exist on this system."
}

# Optional: To disable the service if it's running or set to automatic
if ($service.Status -eq 'Running' -or $service.StartType -ne 'Disabled') {
    Stop-Service -Name $serviceName -Force
    Set-Service -Name $serviceName -StartupType Disabled
    Write-Output "The 'Bluetooth Audio Gateway Service (BTAGService)' has been DISABLED."
}
