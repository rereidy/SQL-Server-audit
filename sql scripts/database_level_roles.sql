/*
    File: database_level_roles.sql

    Lists all accounts with database level roles.

    Save output to .csv

    Author: Ron Reidy

    This script comes with no warranty ...use at own risk
    Copyright (C) 2015  Ron Reidy

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; version 2 of the License.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program or from the site that you downloaded it
    from; if not, write to the Free Software Foundation, Inc., 59 Temple
    Place, Suite 330, Boston, MA  02111-1307   USA

*/

SELECT what.permission_name AS [Permission Name],
       what.state_desc AS [Permission State],
       who.name AS [Principal Name],
       who.type_desc AS [Principal Type],
       CASE who.is_disabled
           WHEN 1 THEN 'TRUE'
           ELSE 'FALSE'
       END AS [Principal Is Disabled]
FROM   sys.database_permissions what
       INNER JOIN sys.server_principals who ON who.principal_id = what.grantee_principal_id
WHERE  who.name NOT LIKE '##MS%##'
AND    who.type_desc <> 'SERVER_ROLE'
ORDER BY what.permission_name, who.name;