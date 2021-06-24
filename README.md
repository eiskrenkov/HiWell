# HiWell - 1.17 Spigot Minecraft Server
IP - minecraft.iskrenkov.com, you must be whitelisted to join

## Ruby
This repo includes Vanilla and Spigot Minecraft server CLI and ruby API wrappers

### Vanilla
```ruby
> Minecraft::Version.latest.meta.server_file_url
=> "https://launcher.mojang.com/v1/objects/0a269b5f2c5b93b1712d0f5dc43b6182b9ab254e/server.jar"
```

###### Download server file:
```sh
ruby/bin/vanilla-cli download_vanilla_server --version 1.17 --destination .
```

### Spigot

###### Download Spigot Build Tools:
```sh
ruby/bin/spigot-cli download_spigot_build_tools --version 1.17 --destination .
```

###### Download Spigot plugins:
configuration.yml

```yaml
plugins:
  skinsrestorer: '14.1.0'
```

```sh
ruby/bin/spigot-cli download_spigot_plugins --destination ./plugins
```

## Deployment
Using [Anchor](https://github.com/eiskrenkov/anchor)

```sh
anchor deploy --stage production [--no-build] [--no-push]
```
