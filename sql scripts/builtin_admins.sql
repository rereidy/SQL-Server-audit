/*
    File: builtin_admins.sql

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

SELECT GETDATE() AS dt_rpt,
       SERVERPROPERTY('SERVERNAME') AS server_name,
       r.name  AS SrvRole,
       u.name  AS LoginName
FROM   sys.server_role_members m JOIN
       sys.server_principals r ON m.role_principal_id = r.principal_id  JOIN
       sys.server_principals u ON m.member_principal_id = u.principal_id
WHERE  u.name = 'BUILTIN\Administrators';
