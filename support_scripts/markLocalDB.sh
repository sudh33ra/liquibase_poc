#!/usr/bin/env bash
# Set WORKSPACE to current working directory
WORKSPACE=$(pwd)
mkdir -p $WORKSPACE/temp
# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
       --schema-name)
            SCHEMA_NAME="$2"
            shift 2
            ;;
       *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Check if all required arguments are provided
if [[ -z "$SCHEMA_NAME" ]]; then
    echo "Usage: $0 --schema-name <schema_name>"
    exit 1
fi
docker run --network host -v $WORKSPACE:$WORKSPACE liquibase/liquibase:4.27 \
--changeLogFile=$SCHEMA_NAME.root.changelog.xml \
--defaultsFile=$WORKSPACE/liquibase-local.properties \
--default-schema-name=$SCHEMA_NAME \
--driver=com.mysql.cj.jdbc.Driver \
--classpath=$WORKSPACE/lib/mysql-connector-j-8.3.0.jar \
--searchPath=$WORKSPACE \
changelogSync
