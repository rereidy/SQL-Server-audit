/*
    File: all_db_all_public.sql

    List all objects in all databases which have public access.

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
CREATE TABLE #all_public (db VARCHAR(70),
                          name VARCHAR(256),
                          type_desc VARCHAR(120),
                          grantor VARCHAR(256),
                          grantee VARCHAR(256)
                         );

EXEC master.sys.sp_msforeachdb
'INSERT INTO #all_public
 SELECT ''?'',
        so.name AS name,
        so.type_desc,
        SUSER_NAME(spo.grantor) as grantor,
        USER_NAME(spo.grantee) AS grantee
 FROM   [?].sys.all_objects as so
        INNER JOIN master.dbo.syspermissions AS spo
        ON so.object_id = spo.id
WHERE   USER_NAME(spo.grantee) = ''public''';

SELECT *
FROM   #all_public
ORDER BY db, name;

DROP TABLE #all_public;
