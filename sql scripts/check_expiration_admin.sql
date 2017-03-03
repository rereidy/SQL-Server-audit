/*
    File: check_expiration_admin.sql

    Check that is_expiration_checked is enabled for all administrative accounts.

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

SELECT l.[name], 'sysadmin membership' AS 'Access_Method',
        CASE is_expiration_checked
	       WHEN 1 THEN 'TRUE'
		   ELSE 'FALSE'
	   END as is_expiration_checked,
	   CASE is_policy_checked
	       WHEN 1 THEN 'TRUE'
		   ELSE 'FALSE'
	   END as is_security_policy_checked,
	   CASE is_disabled
	       WHEN 1 THEN 'TRUE'
	       ELSE 'FALSE'
	   END as is_disabled
FROM   sys.sql_logins AS l
WHERE  IS_SRVROLEMEMBER('sysadmin',name) = 1
AND    l.is_expiration_checked <> 1
UNION ALL
SELECT l.[name], 'serveradmin membership' AS 'Access_Method',
        CASE is_expiration_checked
	       WHEN 1 THEN 'TRUE'
		   ELSE 'FALSE'
	   END as is_expiration_checked,
	   CASE is_policy_checked
	       WHEN 1 THEN 'TRUE'
		   ELSE 'FALSE'
	   END as is_security_policy_checked,
	   CASE is_disabled
	       WHEN 1 THEN 'TRUE'
	       ELSE 'FALSE'
	   END as is_disabled
FROM   sys.sql_logins AS l
WHERE  IS_SRVROLEMEMBER('serveradmin',name) = 1
AND    l.is_expiration_checked <> 1
UNION ALL
SELECT l.[name], 'securityadmin membership' AS 'Access_Method',
        CASE is_expiration_checked
	       WHEN 1 THEN 'TRUE'
		   ELSE 'FALSE'
	   END as is_expiration_checked,
	   CASE is_policy_checked
	       WHEN 1 THEN 'TRUE'
		   ELSE 'FALSE'
	   END as is_security_policy_checked,
	   CASE is_disabled
	       WHEN 1 THEN 'TRUE'
	       ELSE 'FALSE'
	   END as is_disabled
FROM   sys.sql_logins AS l
WHERE  IS_SRVROLEMEMBER('securityadmin',name) = 1
AND    l.is_expiration_checked <> 1
UNION ALL
SELECT l.[name], 'CONTROL SERVER' AS 'Access_Method',
        CASE is_expiration_checked
	       WHEN 1 THEN 'TRUE'
		   ELSE 'FALSE'
	   END as is_expiration_checked,
	   CASE is_policy_checked
	       WHEN 1 THEN 'TRUE'
		   ELSE 'FALSE'
	   END as is_security_policy_checked,
	   CASE is_disabled
	       WHEN 1 THEN 'TRUE'
	       ELSE 'FALSE'
	   END as is_disabled
FROM   sys.sql_logins AS l
JOIN   sys.server_permissions AS p
ON     l.principal_id = p.grantee_principal_id
WHERE  p.type = 'CL' AND p.state IN ('G', 'W')
AND    l.is_expiration_checked <> 1;