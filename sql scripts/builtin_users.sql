/*
    File: builtin_users.sql

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

use master
go

SET NOCOUNT ON
CREATE TABLE #all_users (db VARCHAR(70), sid VARBINARY(85), stat VARCHAR(50));

EXEC master.sys.sp_msforeachdb
'INSERT INTO #all_users
 SELECT ''?'', CONVERT(varbinary(85), sid) ,
        CASE
            WHEN r.role_principal_id IS NULL AND p.major_id IS NULL THEN ''no_db_permissions''
            ELSE ''db_user''
        END
 FROM   [?].sys.database_principals u LEFT JOIN [?].sys.database_permissions p
   ON    u.principal_id = p.grantee_principal_id
   AND   p.permission_name <> ''CONNECT''
  LEFT JOIN [?].sys.database_role_members r
   ON u.principal_id = r.member_principal_id
  WHERE  u.SID IS NOT NULL AND u.type_desc <> ''DATABASE_ROLE''';

IF EXISTS
(SELECT l.name
 FROM    sys.server_principals l LEFT JOIN sys.server_permissions p
   ON    l.principal_id = p.grantee_principal_id
  AND    p.permission_name <> 'CONNECT SQL'
 LEFT JOIN sys.server_role_members r
   ON    l.principal_id = r.member_principal_id
 LEFT JOIN #all_users u
   ON    l.sid= u.sid
 WHERE   r.role_principal_id IS NULL  AND l.type_desc <> 'SERVER_ROLE'
   AND   p.major_id IS NULL
 )
BEGIN
 SELECT DISTINCT l.name LoginName, l.type_desc,
        CASE l.is_disabled
            WHEN 1 THEN 'TRUE'
            ELSE 'FALSE'
        END AS is_disabled,
        ISNULL(u.stat + ', but is user in ' + u.db  +' DB', 'no_db_users') AS db_perms,
        CASE
            WHEN p.major_id IS NULL AND r.role_principal_id IS NULL THEN 'no_srv_permissions'
            ELSE 'na'
        END AS srv_perms
 FROM   sys.server_principals l LEFT JOIN sys.server_permissions p
   ON   l.principal_id = p.grantee_principal_id
  AND   p.permission_name <> 'CONNECT SQL'
  LEFT JOIN sys.server_role_members r ON l.principal_id = r.member_principal_id
  LEFT JOIN #all_users u ON l.sid= u.sid
 WHERE  l.type_desc <> 'SERVER_ROLE'
 AND    ((u.db IS NULL  AND p.major_id IS NULL
          AND r.role_principal_id IS NULL
         )
         OR (u.stat = 'no_db_permissions'
             AND p.major_id IS NULL
             AND r.role_principal_id IS NULL
            )
        )
 ORDER BY 1, 4;
END;

DROP TABLE #all_users;
