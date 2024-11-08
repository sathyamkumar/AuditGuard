(L1) Ensure 'Computer Browser (Browser)' is set to 'Disabled' or 'Not Installed'


# Define the service name
$serviceName = "Browser"

# Get the service status
$service = Get-Service -Name "Bowser" -ErrorAction SilentlyContinue

# Check if the service exists
if ($service) {
    # Output the current status of the service
    if ($service.Status -eq 'Stopped' -and $service.StartType -eq 'Disabled') {
        Write-Output "The 'Computer Browser (Browser)' service is DISABLED."
    } elseif ($service.Status -eq 'Running') {
        Write-Output "The 'Computer Browser (Browser)' service is ENABLED. It is recommended to disable this service."
        # Stop the service and set it to disabled
        Stop-Service -Name "Bowser" -Force
        Set-Service -Name "Bowser" -StartupType Disabled
        Write-Output "The 'Computer Browser (Browser)' service has been DISABLED."
    } else {
        Write-Output "The 'Computer Browser (Browser)' service is STOPPED but not set to DISABLED. Please check the service configuration."
    }
} else {
    Write-Output "The 'Computer Browser (Browser)' service does not exist on this system."
}
