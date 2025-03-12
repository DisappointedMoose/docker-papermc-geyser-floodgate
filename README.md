## Forked From:
- (https://github.com/davidsauro/docker-papermc-geyser-floodgate).

## Why Fork?
The install script in the above image was using outdated API URLs. Also I wanted to switch to a more lightweight docker image based on alpine.

# PaperMC-Geyser-Floodgate
This is a Linux Docker image for the PaperMC Minecraft server, GeyserMC, and Floodgate.

PaperMC is an optimized Minecraft server with plugin support (Bukkit, Spigot, Sponge, etc.).
This image provides a PaperMC server with the Geyser and Floodgate plugins, which allow Bedrock players to join a Java server. Floodgate allows a user to log in with their Microsoft Account 
# Install Docker
It is assumed that the user has already acquired a working Docker installation. If that is not the case, go do that and come back here when you're done. [Docker Install Guide](https://docs.docker.com/get-docker/)

Docker can also be installed by running the following commands
```shell
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh --dry-run
```

# Pull / Build
This image is available here: `docker pull disappointedmoose/papermc-geyser-floodgate:latest`

If you want to build it yourself. This is a very simple process.

```shell
git clone https://github.com/DisappointedMoose/docker-papermc-geyser-floodgate.git
cd papermc-geyser-docker
docker build . -t disappointedmoose/papermc-geyser-floodgate:latest
```
## Command
### Important Note
*Don't run the following commands as the root user or with root privileges. That isn't needed if docker is set up correctly along with your file permissions. This applies to any command that says `docker run`*

With this image, you can create a new PaperMC Minecraft server with one command (note that running said command indicates agreement to the Minecraft EULA). Here is an example:

```docker run -p 25565:25565 -p 19132:19132/udp disappointedmoose/papermc-geyser-floodgate```

While this command will work just fine in many cases, it is only the bare minimum required to start a functional server and can be vastly improved by specifying some...
## Options
There are several command line options that users may want to specify when utilizing this image. These options are listed below with some brief explanation. An example will be provided with each. In the example, the part that the user can change will be surrounded by angle brackets (`< >`). Remember to *remove the angle brackets* before running the command.
- Port
  - This option must be specified. Use ports `25565` and `19132` if you don't know what this is.
  - Set this to the port number that the server will be accessed from.
  - If RCON is to be used, this option must be specified a third time for port `25575`.
  - `-p <12345>:25565 -p <23456>:19132/udp`
  - `-p <12345>:25565 -p <23456>:19132/udp -p <34567>:25575`
  - *Do not* remove the `/udp` after `19132`. It is essential for Bedrock support.

- Volume
  - Set this to a name for the server's Docker volume (defaults to randomized gibberish).
  - Alternatively, set this to a path to a folder on your computer.
  - `-v <my_volume_name>:/papermc`
  - `-v </path/to/files>:/papermc`
- Detached
  - Include this to make the container independent from the current command line.
  - `-d`
- Terminal/Console
  - Include these flags if you want access to the server's command line via `docker attach`.
  - These flags can be specified separately or as one option.
  - `-t` and `-i` in any order
  - `-ti` or `-it`
- Restart Policy
  - If you include this, the server will automatically restart if it crashes.
  - Stopping the server from its console will still stop the container.
  - It is highly recommended to only stop the server from its console (not via Docker).
  - `--restart on-failure`
- Name
  - Set this to a name for the container (defaults to a couple of random words).
  - `--name "<my-container-name>"`
- User
	- Set the UID of the user that will be running this container. This helps avoid file permission issues.
	- `--user 1000:1000`

The command I would recommend using goes something like this:

```docker run -p 25565:25565 -p 19132:19132/udp -v /home/minecraft/server:/papermc -d -ti --restart on-failure -e MC_RAM="4G" -e TZ="America/Toronto" --name "minecraft" --user 1001:1001 disappointedmoose/papermc-geyser-floodgate:latest```

Replace the timezone, uid, and allocated ram with the correct values for your system.

There is one more command line option, but it is a bit special and deserves its own section.

### Environment Variables
| Variable           | Default            | Description                                                                                                                                                                                                                                                                       | 
|--------------------|--------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `MC_VERSION`       | `latest`           | The Minecraft version the server should use                                                                                                                                                                                                                                       |
| `PAPER_BUILD`      | `latest`           | The PaperMC build the server should use. `latest` uses the latest stable build for the specified `MC_VERSION`<br/><br/>*PaperMC builds are tied to Minecraft versions. So if you specify a specific PaperMC build, it's a good idea to also specify a specific Minecraft Version* |
| `MC_RAM`           | `4G`               | The amount of RAM the server can use.                                                                                                                                                                                                                                             |
| `JAVA_OPTS`        | *empty*            | Additional Java command line options that should be included.<br/><br/>*-Xms and -Xmx are already included by default and can be modified by `MC_RAM` environment variable*                                                                                                       |
| `GAMEMODE`         | `survival`         | Game mode of the server                                                                                                                                                                                                                                                           |
| `MOTD`             | `Minecraft server` | Message of the Day displayed in the server browser of Minecraft                                                                                                                                                                                                                   |
| `DIFFICULTY`       | `peaceful`         | Difficulty of the server                                                                                                                                                                                                                                                          |
| `ENABLE_WHITELIST` | `false`            | If whitelist should be used                                                                                                                                                                                                                                                       |


## Further Setup
From this point, the server should be configured in the same way as any other Minecraft server. The server's files, including `server.properties`, can be found in the volume that was specified earlier. The port that was specified earlier will probably need to be forwarded as well. For details on how to do this and other such configuration, Google it, because it works the same as any other Minecraft server.

*Note: Some entries `server.properties` can be configured via environment variables. These WILL be overwritten on EVERY start of the container*

# Technical
This project *does **NOT** redistribute the Minecraft server files*. Instead, the (very small) script that is inside of the image, `papermc.sh`, downloads these files from their official sources during installation.

**PLEASE NOTE:** 
This is an unofficial project.

I did not create PaperMC. [This is the official PaperMC website.](https://papermc.io/)

I did not create Geyser or Floodgate [This is the official GeyserMC website](https://geysermc.org/)

## Project Pages
- [GitHub page](https://github.com/DisappointedMoose/docker-papermc-geyser-floodgate.git).
