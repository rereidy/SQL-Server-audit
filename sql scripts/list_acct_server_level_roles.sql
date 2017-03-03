/*
    File: list_acct_server_level_roles.sql

    List all accounts and their server level roles.

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

SELECT GETDATE() AS [RPT_DATE],
       SERVERPROPERTY('SERVERNAME') AS [SERVERNAME],
       B.NAME AS [LOGINNAME],
       CASE B.SYSADMIN
           WHEN '1' THEN 'TRUE'
           ELSE 'FALSE'
       END AS SYSADMIN,
       CASE B.SECURITYADMIN
           WHEN '1' THEN 'TRUE'
           ELSE 'FALSE'
       END AS SECURITYADMIN,
       CASE B.SETUPADMIN
           WHEN '1' THEN 'TRUE'
           ELSE 'FALSE'
       END AS SETUPADMIN,
       CASE B.PROCESSADMIN
           WHEN '1' THEN 'TRUE'
           ELSE 'FALSE'
       END AS PROCESSADMIN,
       CASE B.DISKADMIN
           WHEN '1' THEN 'TRUE'
           ELSE 'FALSE'
       END AS DISKADMIN,
       CASE B.DBCREATOR
           WHEN '1' THEN 'TRUE'
           ELSE 'FALSE'
       END AS DBCREATOR,
       CASE B.BULKADMIN
           WHEN '1' THEN 'TRUE'
           ELSE 'FALSE'
       END AS BULKADMIN,
       B.DBNAME AS [DEFAULT_DBNAME]
FROM MASTER..SYSLOGINS B;