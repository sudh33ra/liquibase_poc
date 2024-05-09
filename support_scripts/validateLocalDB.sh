#!/usr/bin/env bash
# Set WORKSPACE to current working directory
WORKSPACE=$(pwd)

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --hostname)
            hostname="$2"
            shift 2
            ;;
        --portnumber)
            portnumber="$2"
            shift 2
            ;;
        --schema-name)
            SCHEMA_NAME="$2"
            shift 2
            ;;
        --lquser)
            lquser="$2"
            shift 2
            ;;
        --lqpassword)
            lqpassword="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Check if all required arguments are provided
if [[ -z "$hostname" || -z "$portnumber" || -z "$SCHEMA_NAME" || -z "$lquser" || -z "$lqpassword" ]]; then
    echo "Usage: $0 --hostname <hostname> --portnumber <portnumber> --schema-name <schema_name> --lquser <lquser> --lqpassword <lqpassword>"
    exit 1
fi

docker run -v $WORKSPACE:$WORKSPACE liquibase/liquibase:4.27 \
--url=jdbc:mysql://$hostname:$portnumber/$SCHEMA_NAME \
--username=$lquser \
--password=$lqpassword \
--changeLogFile=$SCHEMA_NAME.root.changelog.xml \
--driver=com.mysql.cj.jdbc.Driver \
--classpath=$WORKSPACE/lib/mysql-connector-j-8.3.0.jar \
--searchPath=$WORKSPACE \
updateSQL
