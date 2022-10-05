# Webcode
Docker image to run [code-server](https://github.com/linuxserver/docker-code-server) on a rpi.  
I am using it to mount my configuration-folder of the [home-assistant](https://www.home-assistant.io/) intance.
  
# Environment file

To build the image you have to create a file `.env` in the root folder.  
Should look like the following example: 

```bash
# used for imagetag
VERSION=v0.1
# set the used version
CODE_SERVER_VERSION=4.7.1
# set the architecture
CODE_SERVER_ARCHITECTURE=arm64v8
UID=1000
GID=124
# Path to store the config
CODE_CONFIG_PATH=/<PATH>/config
# Path to you workspace e.g. homeassistant config
CODE_WORKSPACE_PATH=/<PATH>/homeassistant
```

# Build / Run
Build: `docker-compose build`  
Run: `docker-compose up -d`  