# Generate a new changelog

#### You can create a copy of the given `example.mydb.mysql.sql` file and add your statements ([Further Reading](https://docs.liquibase.com/concepts/changelogs/sql-format.html)), or use the below process to automatically generate the file with your changes by comparing the local db against a staging db.
---
# Generate a new changelog by comparing against a remote DB

## Using Docker
1. Make sure you have docker installed 
1. Setup the `liquibase-remote.properties` file to match your local db (with changes) as source(aka reference) and one of the staging dbs (without changes) as target
1. If this is the first time you're running liquibase, please follow the **Initiate Local DB Liquibase tracking** guide first
1. Run the below command, replacing the variables
```shell
./support_scripts/generateChangeLogRemote.sh --schema-name <schema_name> --change-tag <change_tag> --db-change-version <db_change_version>
#for example : ./support_scripts/generateChangeLogRemote.sh --schema-name mydb --change-tag myapp-v1.2.3 --db-change-version 0.1.2
```

where


| var | desc |
| ------ | ----- |
| `db_change_version` |  For example, `1.2.3`. Note that this ID defines the order of application of changes |
| `change_tag` | this could include the changed component and a number. for example, `myapp-v1.2.3` |
| `schema-name` | for example, 'mydb' |

Note : please make sure that the created file contains **only** the changes that are intentended to go live

# Initiate Local DB Liquibase tracking

## Using Docker
1. Make sure you have docker installed 
1. Setup the `liquibase-local.properties` file to match your local db
1. Run the below command, replacing the variables
```shell
./support_scripts/initLocalDB.sh --schema-name <schema_name>
#for example : ./support_scripts/initLocalDB.sh --schema-name mydb
```

where


| var | desc |
| ------ | ----- |
| `schema-name` | for example, 'mydb' |


# Mark your local db as up-to-date with the latest changes
if you're getting unintended changes when you try to generate a new change log, you may run the below command to mark your local db as up to date.

```shell
./support_scripts/markLocalDB.sh --schema-name mydb
```

note that this will not make any DB changes. Only the liquibase log will be changed.
