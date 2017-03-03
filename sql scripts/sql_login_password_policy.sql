/*
    File: sql_login_password_policy.sql

    Check SQL server password policy is enabled for SQL logins.

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

SELECT name,
       CASE is_policy_checked
	       WHEN 1 THEN 'TRUE'
		   ELSE 'FALSE'
	   END as is_security_policy_checked,
	   CASE is_expiration_checked
	       WHEN 1 THEN 'TRUE'
		   ELSE 'FALSE'
	   END as is_expiration_checked,
	   CASE is_disabled
	       WHEN 1 THEN 'TRUE'
	       ELSE 'FALSE'
	   END as is_disabled
FROM   sys.sql_logins;