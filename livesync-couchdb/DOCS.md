# LiveSync CouchDB

CouchDB server for [Obsidian LiveSync](https://github.com/vrtmrz/obsidian-livesync) - sync your Obsidian vault across all your devices.

## Configuration

### Options

| Option | Description |
|--------|-------------|
| `username` | CouchDB admin username (default: `admin`) |
| `password` | CouchDB admin password (**required**) |
| `secret_path` | URL path prefix to hide CouchDB (default: `sync`) |

### Example Configuration

```yaml
username: admin
password: your-secure-password-here
secret_path: sync
```

## Reverse Proxy Setup

This add-on exposes CouchDB on port 5984. You need a reverse proxy (like Caddy or nginx) to:
1. Provide HTTPS/SSL termination
2. Handle CORS headers for Obsidian
3. Route the secret path to CouchDB

### Caddy Configuration

Add this to your Caddyfile:

```
livesync.yourdomain.com {
    # Secret path - strip /sync/ prefix and forward to CouchDB
    handle_path /sync/* {
        reverse_proxy localhost:5984 {
            header_up Host {host}
        }
    }

    # CORS headers for Obsidian app
    header {
        Access-Control-Allow-Origin "app://obsidian.md"
        Access-Control-Allow-Methods "GET, PUT, POST, HEAD, DELETE"
        Access-Control-Allow-Headers "accept, authorization, content-type, origin, referer"
        Access-Control-Allow-Credentials "true"
    }

    # Block root access (only /sync/ path works)
    handle {
        respond "Not Found" 404
    }
}
```

Replace:
- `livesync.yourdomain.com` with your domain
- `/sync/` with your `secret_path` value

## Post-Installation

### 1. Initialize CouchDB Databases

After starting the add-on, initialize the required databases:

```bash
# Replace with your domain, secret_path, username, and password
curl -X PUT "https://livesync.yourdomain.com/sync/_users" \
  -u "admin:your-password"

curl -X PUT "https://livesync.yourdomain.com/sync/_replicator" \
  -u "admin:your-password"

curl -X PUT "https://livesync.yourdomain.com/sync/obsidian" \
  -u "admin:your-password"
```

### 2. Configure Obsidian LiveSync Plugin

In Obsidian, install the LiveSync plugin and configure:

| Setting | Value |
|---------|-------|
| URI | `https://livesync.yourdomain.com/sync` |
| Username | Your configured username |
| Password | Your configured password |
| Database | `obsidian` (or your chosen name) |

### 3. Verify Connection

In Obsidian LiveSync settings, click "Test Connection" to verify everything works.

## Troubleshooting

### Connection Refused

- Ensure the add-on is running
- Check that port 5984 is not blocked
- Verify your reverse proxy configuration

### CORS Errors

- Ensure CORS headers are set in your reverse proxy
- The `Access-Control-Allow-Origin` must include `app://obsidian.md`

### Authentication Failed

- Double-check username and password
- Ensure the password in the add-on matches what you use in Obsidian

### Database Not Found

- Run the initialization curl commands above
- Ensure you're using the correct database name in Obsidian

## Data Location

All CouchDB data is stored in `/data/couchdb` which persists across add-on updates and restarts.

## Security Notes

- Always use a strong, unique password
- The `secret_path` adds obscurity but is not a security measure on its own
- All traffic should go through HTTPS
- Authentication is required for all CouchDB operations
