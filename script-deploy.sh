#! /bin/bash

docker load -i vollmed-api.tar

mv docker-compose-prod.yaml docker-compose.yaml

container_ids=$(docker ps -q)

if [ -z "$container_ids" ]; then
  echo "No running containers found."
else
  for container_id in $container_ids; do
    echo "Stopping container $container_id"
    docker stop "$container_id"
  done

  echo "All running containers have been stopped."
fi

docker-compose up -d