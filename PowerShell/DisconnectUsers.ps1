##################################################
#     This script forces the logout of users     # 
#        who are in disconnected status.         #          
#                       V1.0                     #
##################################################

# List all disconnect users
$disconnected_users = Get-RDUserSession | Where-Object -Filter {$_.SessionState -eq 'STATE_DISCONNECTED'} 

# For every disconnect user 
Foreach($disconnected_user in $disconnected_users) 
{ 
	# Add log
	Add-Content "$PSScriptRoot\DisconnectedUsers.log" -Value "$(Get-Date -Format 'dd/mm/yyyy hh:mm') | Disconnect user $($disconnected_user.UserName) with session ID : $($disconnected_user.UnifiedSessionId)"
	# Log off user
	Invoke-RDUserLogoff -HostServer $((Get-WmiObject win32_computersystem).DNSHostName+"."+(Get-WmiObject win32_computersystem).Domain) $disconnected_user.UnifiedSessionId -Force
}