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

