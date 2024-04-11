# Export data from an Oracle RDS instance and create a dump file on a local host
<strong>The aim of this project is to export schemas with the datapump utility from an Oracle RDS instance and save it on the local host</strong>

For this project we are going to follow the AWS documentation: https://repost.aws/knowledge-center/rds-oracle-instant-client-datapump

To export the data from an Oracle RDS instance and create a dump file locally, do the following:
  - Download and install an Oracle Express Edition (XE) database on the local host: [Oracle Database XE Quick Start](https://www.oracle.com/za/database/technologies/appdev/xe/quickstart.html)
  - Log in to the Oracle XE database with SQL*Plus.
  - Create a directory on the Oracle XE database. This directory will reference the directory where we want to create the dump file (exported file).
  - On the Oracle XE database, create a database link to our source Oracle RDS database.
  - Create the dump file using the expdp utility

<strong>Download and install an Oracle Express Edition (XE)</strong>

Download the Microsoft Windows version of Oracle Database XE. Extract the downloaded zip file to a temporary location. Locate setup.exe and double click it.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/f6f63d94-76df-4b52-9b3a-2f4ebb017b1a)

In the Destination Folder window, either accept the default location or click Change to select a different installation directory.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/cbd190a9-59b7-417f-89fb-5e225420e08e)

In the Oracle Database Information window, enter and confirm the single database password to use for the SYS, SYSTEM, and PDBADMIN database accounts.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/4c89ab4b-99c7-4993-b118-30fc6a2df6dd)

In the Summary window, review the installation settings, and if you are satisfied, click Install. Otherwise, click Back and modify the settings as necessary. When the installation is complete, the Oracle Database Installed Successfully window is displayed.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/135aba69-101e-4124-b50e-ca899e81a222)


<strong>Log in to the Oracle XE database with SQL*Plus</strong>

Check the OracleServiceXE to get the ORACLE_SID and ORACLE_HOME.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/5ba269d4-2b56-43e3-8206-744193486e90)

Open a cmd window, set the the ORACLE_SID and ORACLE_HOME variables and connect with the user system to the Oracle XE database.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/84e5e541-f462-452e-aec1-ac2777fb15ea)

Create a directory on the Oracle XE database. Make sure the path exists on the local server.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/0e4a3536-243b-4ec1-8d8e-b547b4b23e6e)


Create a database link to your source RDS database. I have used the system user to create the database link.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/34ee610b-6349-4e35-95f7-0f245b6fcbb1)

We can check the database link has been successfully created by running the following query.

    SQL> col OWNER format a25
    SQL> col DB_LINK format a40
    SQL> col USERNAME format a15
    SQL> col host format a40
    SQL> set lines 150 pages 200
    SQL> select OWNER, DB_LINK, USERNAME, host from dba_db_links;

<strong>Export data</strong>

We are going take an export of schema SCHEMA01. Check the schema size. Check that you have enough free space on disk.

    SQL> col owner for a30
    SQL> select owner, sum(bytes)/1024/1024/1024 GB from dba_segments where owner='SCHEMA01' group by owner;


Check the oracle variables are set correctly and run the export using the expdp utility.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/a895a1aa-11da-4fe7-b7ea-8d760f4011da)





