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
[![License: MIT][license-shield]][license]

CouchDB server optimized for Obsidian LiveSync with:
- Configurable admin credentials
- Secret path support for security
- Persistent data storage
- CORS pre-configured for Obsidian

## Credits

This add-on is built for use with the excellent [Obsidian LiveSync](https://github.com/vrtmrz/obsidian-livesync) plugin by [@vrtmrz](https://github.com/vrtmrz).

Related projects:
- [Obsidian LiveSync](https://github.com/vrtmrz/obsidian-livesync) - The Obsidian plugin for real-time sync
- [Self-hosted LiveSync Server](https://github.com/vrtmrz/self-hosted-livesync-server) - Official self-hosted server setup

## License

MIT License - see [LICENSE](LICENSE) for details.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[license-shield]: https://img.shields.io/badge/License-MIT-yellow.svg
[license]: LICENSE
