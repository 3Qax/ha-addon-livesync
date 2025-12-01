#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

# Read configuration from Home Assistant
COUCHDB_USER=$(bashio::config 'username')
COUCHDB_PW=$(bashio::config 'password')
SECRET_PATH=$(bashio::config 'secret_path')

bashio::log.info "Starting LiveSync CouchDB server..."

# Validate password is set
if [ -z "$COUCHDB_PW" ]; then
    bashio::log.error "Password is not set! Please configure a password in the add-on settings."
    exit 1
fi

# Create persistent data directory
mkdir -p /data/couchdb
chown -R couchdb:couchdb /data/couchdb

# Link data directory to CouchDB location
rm -rf /opt/couchdb/data
ln -sf /data/couchdb /opt/couchdb/data

# Generate CouchDB configuration with credentials
bashio::log.info "Configuring CouchDB..."
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

bashio::log.info "CouchDB configured successfully"
bashio::log.info "Access CouchDB at: https://YOUR_DOMAIN/${SECRET_PATH}/"
bashio::log.info "Username: ${COUCHDB_USER}"

# Start CouchDB as couchdb user
exec su-exec couchdb /opt/couchdb/bin/couchdb
