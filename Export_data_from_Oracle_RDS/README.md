# Export data from an Oracle RDS instance and create a dump file on a local host
<strong>The aim of this project is to export schemas with the datapump utility from an Oracle RDS instance and save it on the local host</strong>

For this project we are going to follow the AWS documentation: https://repost.aws/knowledge-center/rds-oracle-instant-client-datapump

To export the data from an Oracle RDS instance and create a dump file locally, do the following:
  - Download and install an Oracle Express Edition (XE) database on the local host: [Oracle Database XE Quick Start](https://www.oracle.com/za/database/technologies/appdev/xe/quickstart.html)
  - Log in to the Oracle XE database with SQL*Plus.
  - Create a directory on the Oracle XE database. This directory will reference the directory where we want to create the dump file (exported file).
  - On the Oracle XE database, create a database link to our source Oracle RDS database.
  - Create the dump file using the expdp utility

