/*
    File: db_endpoints.sql

    List all database endpoints.

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

SELECT * FROM sys.endpoints;
SELECT * FROM sys.endpoint_webmethods;
SELECT * FROM sys.database_mirroring_endpoints;
SELECT * FROM sys.tcp_endpoints;
SELECT * FROM sys.http_endpoints;
SELECT * FROM sys.via_endpoints;