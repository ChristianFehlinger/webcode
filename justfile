set shell := ["bash", "-c"]

# default recipe to display
@default:
  just --list

# start all container
@up:
  docker-compose up -d

# updates all container
@update:
  docker-compose pull

# stops all container
@down:
  docker-compose down

# restart container
@restart:
  docker-compose down || true
  docker-compose up -d

# build docker image
@build:
  source .build
  docker-compose build

# Clean docker
@clean:
  docker rmi $(docker images | grep "none" | awk '/ / { print $3 }') || true
