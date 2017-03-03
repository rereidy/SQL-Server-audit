/*
    File: list_protocols1.sql

    List SQL server enabled protocols.

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

SELECT perms.class_desc, perms.permission_name, perms.state_desc,
       SUSER_NAME(perms.grantor_principal_id) AS grantor,
       ep.name, ep.protocol_desc,
	   tcp.ip_address, tcp.type_desc, tcp.state_desc,
	   CASE tcp.is_admin_endpoint
	       WHEN 1 THEN 'TRUE'
		   ELSE 'FALSE'
	   END AS is_admin_endpoint,
	   CASE tcp.is_dynamic_port
	       WHEN 1 THEN 'TRUE'
		   ELSE 'FALSE'
	   END AS is_dynamic_port
FROM   sys.server_permissions AS perms
LEFT OUTER JOIN sys.endpoints AS ep ON ep.endpoint_id = perms.major_id
LEFT OUTER JOIN sys.tcp_endpoints AS tcp ON ep.endpoint_id = tcp.endpoint_id
WHERE  perms.grantee_principal_id = SUSER_ID('public');