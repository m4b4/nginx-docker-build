#nginx-docker-build
Dockerfile and scripts to build nginx-1.4.0 on ubuntu 13.04 and copy resulting binaries to the host without running a container.

1. Run `./build_docker.sh` to create the image.
2. Run `./create_n_copy.sh` to create temporary container and copy the binaries that have been build in step 1 into the cwd.
