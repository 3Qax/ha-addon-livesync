# Home Assistant Add-on: LiveSync CouchDB

CouchDB server for Obsidian LiveSync - sync your Obsidian vault across devices.

## Installation

1. Add this repository to your Home Assistant Add-on Store:
   - Go to **Settings** > **Add-ons** > **Add-on Store**
   - Click the menu (⋮) > **Repositories**
   - Add: `https://github.com/3Qax/ha-addon-livesync`

2. Find "LiveSync CouchDB" in the store and click **Install**

3. Configure the add-on with your username and password

4. Start the add-on

5. Set up your reverse proxy (see [DOCS.md](livesync-couchdb/DOCS.md))

## Add-ons in this Repository

### [LiveSync CouchDB](livesync-couchdb)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armv7 Architecture][armv7-shield]

CouchDB server optimized for Obsidian LiveSync with:
- Configurable admin credentials
- Secret path support for security
- Persistent data storage
- CORS pre-configured for Obsidian

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
