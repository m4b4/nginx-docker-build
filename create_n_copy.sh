docker create -ti --name nginx-builder-container nginx-builder bash
docker cp nginx-builder-container:/opt/nginx/ .
docker rm -f nginx-builder-container
