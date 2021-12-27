#if the command requires a confirmation, you must append \ny to that command.
# example: copy running-config startup-config\ny
# This auto accepts the confirmation.

$Username = SWITCH_USER
$Password = SWITCH_PASS

$CURRENT_COMMAND = "SCRIPT_ROOT\current_command.txt"

if ((Test-Path $CURRENT_COMMAND) -eq $true)
{
    rm $CURRENT_COMMAND
}


Set-Location "WHERE YOU SCRIPTS ARE LOCATED"

$CSV_LOCATION = Read-Host "Please enter the FQDN path to your switchlist csv"
while ((Test-Path $CSV_LOCATION) -eq $false)
{
    Write-Host "This is not a valid file location"
    $CSV_LOCATION = Read-Host "Please enter the FQDN path to your switchlist csv"
}
$SwitchList = Import-Csv $CSV_LOCATION | sort NodeName 


$COMMAND_NUMBER = Read-Host "How many commands are you going to run? (Not including Yes confirmations)"
for (($i = 0); $i -lt $COMMAND_NUMBER; $i++)
{
    Remove-Variable -Name "Command$i"
    New-Variable -Name "Command$i" -Value ($READHOST = READ-HOST "Enter Command")
    Get-Variable -Name "Command$i" -ValueOnly | Out-File -FilePath $CURRENT_COMMAND -Append
}

$COMMAND_EXEC = Get-Content $CURRENT_COMMAND
$COMMAND_EXEC | foreach {$_ +  '\n'} | Out-File -FilePath $CURRENT_COMMAND
Add-Content $CURRENT_COMMAND "logout"
$COMMAND_EXEC = Get-Content $CURRENT_COMMAND



foreach ($Switch in $SwitchList)
{
    .\kitty.exe $Switch.IPAddress -ssh -v -l $Username -pw $Password -cmd "$COMMAND_EXEC"
    sleep -Seconds 10
}






