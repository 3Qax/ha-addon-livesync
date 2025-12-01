#!/bin/bash
set -e

# Read configuration from Home Assistant options
OPTIONS_FILE="/data/options.json"

if [ -f "$OPTIONS_FILE" ]; then
    COUCHDB_USER=$(jq -r '.username' "$OPTIONS_FILE")
    COUCHDB_PW=$(jq -r '.password' "$OPTIONS_FILE")
    SECRET_PATH=$(jq -r '.secret_path' "$OPTIONS_FILE")
else
    echo "Warning: No options file found, using defaults"
    COUCHDB_USER="${COUCHDB_USER:-admin}"
    COUCHDB_PW="${COUCHDB_PW:-}"
    SECRET_PATH="${SECRET_PATH:-sync}"
fi

echo "Starting LiveSync CouchDB server..."

# Validate password is set
if [ -z "$COUCHDB_PW" ]; then
    echo "ERROR: Password is not set! Please configure a password in the add-on settings."
    exit 1
fi

# Create persistent data directory
mkdir -p /data/couchdb
chown -R couchdb:couchdb /data/couchdb

# Generate CouchDB configuration
echo "Configuring CouchDB..."
cat > /opt/couchdb/etc/local.d/docker.ini << EOF
[couchdb]
single_node=true
max_document_size = 50000000
database_dir = /data/couchdb
view_index_dir = /data/couchdb

[chttpd]
require_valid_user = true
max_http_request_size = 4294967296
bind_address = 0.0.0.0
port = 5984

[chttpd_auth]
require_valid_user = true
authentication_redirect = /${SECRET_PATH}/_utils/session.html

[httpd]
enable_cors = true

[cors]
origins = app://obsidian.md,capacitor://localhost,http://localhost
credentials = true
headers = accept, authorization, content-type, origin, referer
methods = GET, PUT, POST, HEAD, DELETE
max_age = 3600

[admins]
${COUCHDB_USER} = ${COUCHDB_PW}

[log]
level = info
EOF

chown couchdb:couchdb /opt/couchdb/etc/local.d/docker.ini

echo "CouchDB configured successfully"
echo "Username: ${COUCHDB_USER}"
echo "Secret path: /${SECRET_PATH}/"

# Start CouchDB using the official entrypoint
exec /docker-entrypoint.sh couchdb
