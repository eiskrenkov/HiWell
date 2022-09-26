![mc.iskrenkov.me](https://img.shields.io/endpoint?url=https%3A%2F%2Fminecraft-server-status-badge.vercel.app%2Fapi%2Fserver%2Fmc.iskrenkov.me%3Fport%3D25565)

# HiWell - Spigot Minecraft Server
Use `mc.iskrenkov.me` to connect

## Ruby
This repo includes Vanilla and Spigot Minecraft server CLI and ruby API wrappers

### Tools

###### Fetch latest known Minecraft version:
```sh
$ ruby/bin/tools latest_version
Latest Vanilla Minecraft version is 1.19
```

###### Backup current world
```sh
$ ruby/bin/tools backup --stage production --destination ~/Desktop/hiwell_backups
```
It will download `world`, `world_nether`, `world_the_end` and `usercache.json` from the server into specified location

### Vanilla
###### Download server file:
```ruby
> Minecraft::Version.latest.meta.server_file_url
=> "https://launcher.mojang.com/v1/objects/0a269b5f2c5b93b1712d0f5dc43b6182b9ab254e/server.jar"
```

```sh
$ ruby/bin/vanilla-cli download_server --version 1.17 --destination .
```

### Spigot

###### Download Spigot Build Tools:
```sh
$ ruby/bin/spigot-cli download_build_tools --version 1.17 --destination .
```

###### Find latest plugin version:
```sh
$ ruby/bin/spigot-cli find_latest_plugin_version --name skinsrestorer
Latest version of SkinsRestorer is 14.2.3 (uuid: 003acc70-806f-550f-0039-991c3c35e3fa, id: 464299)
```

###### Download Spigot plugins:
configuration.yml

```yaml
plugins:
  skinsrestorer: '14.1.0'
```

```sh
$ ruby/bin/spigot-cli download_plugins --destination ./plugins
```

## Deployment
Using [Anchor](https://github.com/eiskrenkov/anchor)

```sh
$ anchor deploy --stage production [--no-build] [--no-push]
```
