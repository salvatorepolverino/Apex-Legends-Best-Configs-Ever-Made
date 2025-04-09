# Controlla se è in esecuzione come amministratore
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Riavvia lo script come amministratore
    $arguments = "& '" + $MyInvocation.MyCommand.Definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    exit
}

Get-NetTCPSetting | Select SettingName, CongestionProvider
netsh int tcp set supplemental template=internet congestionprovider=NewReno
netsh int tcp set supplemental template=internetcustom congestionprovider=NewReno
netsh int tcp set supplemental template=Datacenter congestionprovider=NewReno
netsh int tcp set supplemental Template=Compat CongestionProvider=NewReno
netsh int tcp set supplemental template=Datacentercustom congestionprovider=NewReno
Get-NetTCPSetting | Select SettingName, CongestionProvider
pause