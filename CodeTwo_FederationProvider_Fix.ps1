$ts = New-TimeSpan -Days 0 -Hours 0 -Minutes 1
$setTime = (Get-Date) + $ts
$fTime = $setTime.ToString('HH:mm')

$Trigger= New-ScheduledTaskTrigger -At $fTime -Once
$User= [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

$Action= Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Identity\Identities\*_ADAL" -Name "FederationProvider" -Value ""

Register-ScheduledTask -TaskName "CodeTwo_FederationProvider_Fix" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest -Force | Out-Null