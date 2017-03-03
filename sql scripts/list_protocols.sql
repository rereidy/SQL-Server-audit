/*
    File: list_protocols.sql

    Lists all SQL Server protocols.

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

DECLARE @InstanceName nvarchar(50)
DECLARE @value VARCHAR(100)
DECLARE @value_Out VARCHAR(100)
DECLARE @RegKey_InstanceName nvarchar(500)
DECLARE @RegKey nvarchar(500)

SET @InstanceName=CONVERT(nVARCHAR,isnull(SERVERPROPERTY('INSTANCENAME'),'MSSQLSERVER'))

CREATE TABLE #SQLServerProtocols
(ProtocolName nvarchar(25),
 Value        nvarchar(10),
 Data         bit
)

if (SELECT Convert(varchar(1),(SERVERPROPERTY('ProductVersion')))) <> 8
BEGIN
    SET @RegKey_InstanceName='SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL'

    EXECUTE xp_regread
        @rootkey = 'HKEY_LOCAL_MACHINE',
        @key = @RegKey_InstanceName,
        @value_name = @InstanceName,
        @value = @value OUTPUT

    SET @RegKey='SOFTWARE\Microsoft\Microsoft SQL Server\'+@value+'\MSSQLServer\SuperSocketNetLib\Sm'

    Insert into #SQLServerProtocols (Value,Data)

    EXECUTE xp_regread
        @rootkey = 'HKEY_LOCAL_MACHINE',
        @key = @RegKey,
        @value_name = 'Enabled'

    EXECUTE xp_regread
        @rootkey = 'HKEY_LOCAL_MACHINE',
        @key = @RegKey,
        @value_name = 'DisplayName',
        @value = @value_Out OUTPUT

    UPDATE #SQLServerProtocols
    SET    ProtocolName=@value_Out
    WHERE  ProtocolName is null

    SET @RegKey='SOFTWARE\Microsoft\Microsoft SQL Server\'+@value+'\MSSQLServer\SuperSocketNetLib\Np'

    Insert into #SQLServerProtocols (Value,Data)

    EXECUTE xp_regread
        @rootkey = 'HKEY_LOCAL_MACHINE',
        @key = @RegKey,
        @value_name = 'Enabled'

    EXECUTE xp_regread
        @rootkey = 'HKEY_LOCAL_MACHINE',
        @key = @RegKey,
        @value_name = 'DisplayName',
        @value = @value_Out OUTPUT

    UPDATE #SQLServerProtocols
    SET    ProtocolName=@value_Out
    WHERE  ProtocolName is null

    SET @RegKey='SOFTWARE\Microsoft\Microsoft SQL Server\'+@value+'\MSSQLServer\SuperSocketNetLib\TCP'

    Insert into #SQLServerProtocols (Value,Data)

    EXECUTE xp_regread
        @rootkey = 'HKEY_LOCAL_MACHINE',
        @key = @RegKey,
        @value_name = 'Enabled'

    EXECUTE xp_regread
        @rootkey = 'HKEY_LOCAL_MACHINE',
        @key = @RegKey,
        @value_name = 'DisplayName',
        @value = @value_Out OUTPUT

    UPDATE #SQLServerProtocols
    SET    ProtocolName=@value_Out
    WHERE  ProtocolName is null

    SET @RegKey='SOFTWARE\Microsoft\Microsoft SQL Server\'+@value+'\MSSQLServer\SuperSocketNetLib\Via'

    Insert into #SQLServerProtocols (Value,Data)

    EXECUTE xp_regread
        @rootkey = 'HKEY_LOCAL_MACHINE',
        @key = @RegKey,
        @value_name = 'Enabled'

    EXECUTE xp_regread
        @rootkey = 'HKEY_LOCAL_MACHINE',
        @key = @RegKey,
        @value_name = 'DisplayName',
        @value = @value_Out OUTPUT

    UPDATE #SQLServerProtocols
    SET    ProtocolName=@value_Out
    where  ProtocolName is null

END

SELECT ProtocolName,
       IsEnabled=CASE WHEN Data=1 THEN 'Enabled'
                      ELSE 'Disabled' END
FROM  #SQLServerProtocols

DROP TABLE #SQLServerProtocols