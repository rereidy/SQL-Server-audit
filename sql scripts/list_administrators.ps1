#
#	File Name  : list_administrators.ps1
#	Author     : Ron Reidy (WFAS) ronald.e.reidy@wellsfargo.com
#	Requires   : PowerShell V4.0
#

Get-WmiObject win32_groupuser |
Where-Object { $_.GroupComponent -match 'administrators' } |
ForEach-Object {[wmi]$_.PartComponent } | export-csv admins.csv