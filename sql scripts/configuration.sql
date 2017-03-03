/*
    File: configuration.sql

    Get configuration settings for key system configuration items.

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
       CASE CAST(value as int)
	       WHEN 0 THEN 'FALSE'
		   ELSE 'TRUE'
	   END as value_configured,
       CASE CAST(value_in_use as int)
	       WHEN 0 THEN 'FALSE'
		   ELSE 'TRUE'
	   END as value_in_use,
	   CASE CAST(is_dynamic as int)
	       WHEN 0 THEN 'FALSE'
	       ELSE 'TRUE'
	   END as is_dynamic,
	   CASE CAST(is_advanced as int)
	       WHEN o THEN 'FALSE'
	       ELSE 'TRUE'
	   END as is_advanced
	   description
FROM   sys.configurations
WHERE  name IN ('Ole Automation Procedures',
                'Remote access',
		 	    'Remote admin connections',
			    'Scan for startup procs',
			    'cross db ownership chaining',
			    'show advanced options',
			    'c2 audit mode',
			    'remote login timeout (s)',
			    'clr enabled',
			    'default trace enabled',
			    'user instance timeout',
			    'filestream access level',
			    'Database Mail XPs',
			    'SMO and DMO XPs',
			    'xp_cmdshell',
			    'contained database authentication',
			    'ad hoc distributed queries'
               )
ORDER BY name;
