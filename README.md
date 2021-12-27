# DellPowerConnectMassSSHConfig
Push many commands to a batch of Dell 6224/48 using powershell and ssh

# Dependencies 
kitty.exe <br />
switchlist.csv <br />
posh-git (powershell module) <br />
current_command.txt

# Hosts
Windows Host to run Kitty and posh-git

# Scripts
deploy_command.ps1

# deploy_command.ps1
* if the command requires a confirmation, you must append \ny to that command. (When typing in powershell)
* example: copy running-config startup-config\ny
* This auto accepts the confirmation.
