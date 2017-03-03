Get-WmiObject win32_service -computername $env:computername |
select $env:computername, name, state, startname |
where { ($_.name -like "SQLAGENT*" -or $_.Name -like "*SQL*") } | export-csv -path sql_service_ownership.csv