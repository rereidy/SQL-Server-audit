/*
    File: list_acct_database_level_roles.sql

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

use master;
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET ANSI_PADDING ON;

CREATE TABLE #serv_lev_roles
(
      [DBNAME] [SYSNAME] ,
      [USERNAME] [SYSNAME] ,
      [DB_OWNER] [VARCHAR](5) ,
      [DB_ACCESSADMIN] [VARCHAR](5) ,
      [DB_SECURITYADMIN] [VARCHAR](5) ,
      [DB_DDLADMIN] [VARCHAR](5) ,
      [DB_DATAREADER] [VARCHAR](5) ,
      [DB_DATAWRITER] [VARCHAR](5) ,
      [DB_DENYDATAREADER] [VARCHAR](5) ,
      [DB_DENYDATAWRITER] [VARCHAR](5) ,
      [DT_CREATE] [DATETIME] NOT NULL,
      [DT_UPDATE] [DATETIME] NOT NULL,
      [DT_REPORT] [DATETIME] NOT NULL
          CONSTRAINT [DF__DBROLES__CUR_DAT__3A179ED3]  DEFAULT (GETDATE())
) ON [PRIMARY];

INSERT INTO #serv_lev_roles
EXEC SP_MSFOREACHDB
'SELECT ''?'' AS DBNAME,
        CASE USERNAME
		    WHEN ''dbo'' THEN SUSER_NAME(MEMBERUID)
			ELSE USERNAME
		END as [USERNAME],
        MAX(CASE ROLENAME
                WHEN ''DB_OWNER'' THEN ''TRUE''
                ELSE ''FALSE''
            END) AS DB_OWNER,
        MAX(CASE ROLENAME
                WHEN ''DB_ACCESSADMIN ''THEN ''TRUE''
                ELSE ''FALSE''
            END) AS DB_ACCESSADMIN ,
        MAX(CASE ROLENAME
                WHEN ''DB_SECURITYADMIN'' THEN ''TRUE''
                ELSE ''FALSE''
            END) AS DB_SECURITYADMIN,
        MAX(CASE ROLENAME
                WHEN ''DB_DDLADMIN'' THEN ''TRUE''
                ELSE ''FALSE''
            END) AS DB_DDLADMIN,
        MAX(CASE ROLENAME
                WHEN ''DB_DATAREADER'' THEN ''TRUE''
                ELSE ''FALSE''
            END) AS DB_DATAREADER,
        MAX(CASE ROLENAME
                WHEN ''DB_DATAWRITER'' THEN ''TRUE''
                ELSE ''FALSE''
            END) AS DB_DATAWRITER,
        MAX(CASE ROLENAME
                WHEN ''DB_DENYDATAREADER'' THEN ''TRUE''
                ELSE ''FALSE''
            END) AS DB_DENYDATAREADER,
        MAX(CASE ROLENAME
                WHEN ''DB_DENYDATAWRITER'' THEN ''TRUE''
                ELSE ''FALSE''
            END) AS DB_DENYDATAWRITER,
        CREATEDATE,
        UPDATEDATE,
        GETDATE()
 FROM   (SELECT B.NAME AS USERNAME, A.MEMBERUID, C.NAME AS ROLENAME, B.CREATEDATE, B.UPDATEDATE
         FROM   [?].DBO.SYSMEMBERS A
                JOIN [?].DBO.SYSUSERS B ON A.MEMBERUID = B.UID
                JOIN [?].DBO.SYSUSERS C ON A.GROUPUID = C.UID
        ) S
GROUP BY USERNAME, CREATEDATE, UPDATEDATE, MEMBERUID
ORDER BY USERNAME';

SELECT SERVERPROPERTY('SERVERNAME') AS [SERVERNAME],*
FROM   #serv_lev_roles
ORDER BY dbname, username;

DROP TABLE #serv_lev_roles;