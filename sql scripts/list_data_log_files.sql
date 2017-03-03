/*
    File: list_data_log_files.sql

    Get the SQL Server service pack and version.

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

SELECT db.name AS DBName,
       (SELECT mf.Physical_Name
	    FROM   sys.master_files mf
	    WHERE  mf.type_desc = 'ROWS'
	    AND db.database_id = mf.database_id
	   ) AS DataFile,
       (SELECT mf.Physical_Name
	    FROM  sys.master_files mf
	    WHERE mf.type_desc = 'LOG'
	    AND db.database_id = mf.database_id
	   ) AS LogFile
FROM   sys.databases db