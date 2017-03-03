/*
    File: trustworthy.sql

    List of databases, owner, and trustworthy bit.

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
SELECT db.name AS [DATABASE_NAME], SUSER_SNAME(db.owner_sid) AS [OWNER_LOGIN],
       CASE db.is_trustworthy_on
	       WHEN 1 THEN 'TRUE'
		   ELSE 'FALSE'
	   END AS is_trustworthy_on,
	   CASE
	       WHEN slog.sysadmin = 1 AND db.owner_sid != 1 THEN 'TRUE'
		   ELSE 'FALSE'
	   END AS [EXCEPTION]
FROM   sys.databases AS db
JOIN   syslogins AS slog ON db.owner_sid = slog.sid;