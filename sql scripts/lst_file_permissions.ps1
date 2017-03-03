<#  .SYNOPSIS      Get file information
    .DESCRIPTION   This script will get file information using the following PS cmdlets:

	Get-Acl - Get NTFS file permissions.NOTES

	File Name  : lst_file_permissions.ps1
	Author     : Ron Reidy (WFAS) ronald.e.reidy@wellsfargo.com
	Requires   : PowerShell V4.0

	.USAGE    Get file information for a folder (and all files and folders in the folder)
	lst_file_permissions.ps1 -path path_to_folder

#>

param (
	[string]$path = $(throw "-path argument is required")
)

function FileReport {

	$ipaddr = (Get-WmiObject Win32_NetworkAdapterConfiguration | ? { $_.IPAddress -ne $null }).ipaddress
	$header = "Computer,IP,Path,Patched,Debug,PreReleaase,PrivateBuild,SpecialBuild,Language,Created,LastWriteTime,LastAccessTime,CodeSignature,Account,AccessType,FileSystemRights"
	$common_data = "$env:computername.$env:userdnsdomain,$ipaddr"
	Write-Output "Computer: $env:computername.$env:userdnsdomain"
	$ipaddr = (Get-WmiObject Win32_NetworkAdapterConfiguration | ? { $_.IPAddress -ne $null }).ipaddress
    Write-Output "IP Address: $ipaddr"
	write-Output "=============================="

	$files = Get-ChildItem -path $path -recurse | % { $_.FullName }
	ForEach ($file in $files) {
		FileInfo $file
    }
}

function FileInfo {
	param (
		[Parameter(Mandatory=$true)] [System.String]${fname}
	)
        Write-output "File: $fname"
		Get-Item $fname | Select-Object -Property CreationTime,LastWriteTime,LastAccessTime | Format-List

		$acl = Get-Acl -Path $fname
		$acl.Access | Select-Object -Property IdentityReference,AccessControlType,FileSystemRights
		write-Output "=============================="
}

if (Test-Path $path) {
	if (Test-Path $path -pathtype container) {
		FileReport
	}
	else {
		Throw "Error: $path is not a folder"
	}
}
else
{
    Throw "Error: $path not found"
}