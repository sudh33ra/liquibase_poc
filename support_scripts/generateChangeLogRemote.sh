#!/usr/bin/env bash
# Set WORKSPACE to current working directory
WORKSPACE=$(pwd)

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --schema-name)
            SCHEMA_NAME="$2"
            shift 2
            ;;
        --change-tag)
            CHANGE_TAG="$2"
            shift 2
            ;;
        --db-change-version)
            DB_CHANGE_VERSION="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Check if all required arguments are provided
if [[ -z "$SCHEMA_NAME" || -z "$CHANGE_TAG"  || -z "$DB_CHANGE_VERSION" ]]; then
    echo "Usage: $0 --schema-name <schema_name>  --change-tag <change_tag> --db-change-version <db_change_version>"
    exit 1
fi

docker run --network=host -v $WORKSPACE:$WORKSPACE liquibase/liquibase:4.27 \
--driver=com.mysql.cj.jdbc.Driver \
--classpath=$WORKSPACE/lib/mysql-connector-j-8.3.0.jar \
--defaultsFile=$WORKSPACE/liquibase-remote.properties \
--searchPath=$WORKSPACE \
--changeLogFile=$WORKSPACE/db/$DB_CHANGE_VERSION-$CHANGE_TAG.$SCHEMA_NAME.mysql.sql \
--reference-default-schema-name=$SCHEMA_NAME \
--default-schema-name=$SCHEMA_NAME \
diffChangelog

echo "change log generated : $WORKSPACE/db/$DB_CHANGE_VERSION-$CHANGE_TAG.$SCHEMA_NAME.mysql.sql"
