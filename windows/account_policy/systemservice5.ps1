(L2) Ensure 'Geolocation Service (lfsvc)' is set to 'Disabled'

# Define the service name
$serviceName = "lfsvc"

# Get the service
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

# Check if the service exists
if ($service) {
    # Output the current status
    Write-Output "The current status of the Geolocation Service is: $($service.Status)"

    # Disable the service if it's running or not set to Disabled
    if ($service.Status -eq 'Running' -or $service.StartType -ne 'Disabled') {
        Stop-Service -Name $serviceName -Force
        Set-Service -Name $serviceName -StartupType Disabled
        Write-Output "The 'Geolocation Service' has been DISABLED."
    } else {
        Write-Output "The 'Geolocation Service' is already DISABLED."
    }
} else {
    Write-Output "The 'Geolocation Service' does not exist as an installed service."
}
