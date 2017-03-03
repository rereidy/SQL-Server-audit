/*
    File: list_clr.sql

    List all CLR assemblies in the database

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
CREATE TABLE #all_clr (db                  VARCHAR(70),
                       owner               VARCHAR(126),
                       name                VARCHAR(256),
                       clr_name            VARCHAR(8000),
                       permission_set_desc VARCHAR(120),
                       is_visible          VARCHAR(5),
                       create_date         datetime,
                       modify_date         datetime,
                       is_user_defined     VARCHAR(5)
                      );

EXEC master.sys.sp_msforeachdb
'INSERT INTO #all_clr
 SELECT ''?'',
         SUSER_NAME(principal_id) AS owner,
         clr_name,
         name,
         permission_set_desc,
	     CASE CAST(is_visible as int)
	         WHEN 0 THEN ''FALSE''
		     ELSE ''TRUE''
	     END as is_visible,
	     create_date,
	     modify_date,
         CASE CAST(is_user_defined as int)
             WHEN 0 THEN ''FALSE''
             ELSE ''TRUE''
         END as is_user_defined
FROM   sys.assemblies';

SELECT *
FROM   #all_clr;

DROP TABLE #all_clr;
