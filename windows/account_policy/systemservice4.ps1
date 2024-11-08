L2) Ensure 'Downloaded Maps Manager (MapsBroker)' is set to 'Disabled'

# Define the service name
$serviceName = "MapsBroker"

# Get the service status
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

# Check if the service exists
if ($service) {
    # Output the current status of the service
    if ($service.StartType -eq 'Disabled') {
        Write-Output "The 'Downloaded Maps Manager (MapsBroker)' service is already DISABLED."
    } elseif ($service.Status -eq 'Running') {
        Write-Output "The 'Downloaded Maps Manager (MapsBroker)' service is ENABLED. It is recommended to disable this service."
        # Stop the service and set it to disabled
        Stop-Service -Name $serviceName -Force
        Set-Service -Name $serviceName -StartupType Disabled
        Write-Output "The 'Downloaded Maps Manager (MapsBroker)' service has been DISABLED."
    } else {
        Write-Output "The 'Downloaded Maps Manager (MapsBroker)' service is STOPPED but not set to DISABLED. Please check the service configuration."
    }
} else {
    Write-Output "The 'Downloaded Maps Manager (MapsBroker)' service does not exist on this system."
}
