# Plex Media Server

## Install

```sh
wget -qP /tmp https://downloads.plex.tv/plex-media-server-new/1.16.3.1402-22929c8a2/debian/plexmediaserver_1.16.3.1402-22929c8a2_amd64.deb
sudo dpkg -i /tmp/plexmediaserver_1.16.3.1402-22929c8a2_amd64.deb
# Enable Plex Repository
sudo vim /etc/apt/sources.list.d/plexmediaserver.list    # uncomment the last line
wget -q https://downloads.plex.tv/plex-keys/PlexSign.key -O - | sudo apt-key add -
```
