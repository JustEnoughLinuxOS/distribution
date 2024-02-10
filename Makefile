BUILD_DIRS=build.*
-include $(HOME)/.JELOS/options

all: world

system:
	./scripts/image

release:
	./scripts/image release

image:
	./scripts/image mkimage

clean:
	rm -rf $(BUILD_DIRS)

distclean:
	rm -rf ./.ccache* ./$(BUILD_DIRS)

src-pkg:
	tar cvJf sources.tar.xz sources .stamps

docs:
	./tools/foreach './scripts/clean emulators && ./scripts/build emulators'

world: AMD64 RK3588 S922X RK3326 RK3399

AMD64:
	unset DEVICE_ROOT
	PROJECT=PC DEVICE=AMD64 ARCH=i686 ./scripts/build_distro
	PROJECT=PC DEVICE=AMD64 ARCH=x86_64 ./scripts/build_distro

INTEL64:
	unset DEVICE_ROOT
	PROJECT=PC DEVICE=INTEL64 ARCH=i686 ./scripts/build_distro
	PROJECT=PC DEVICE=INTEL64 ARCH=x86_64 ./scripts/build_distro

RK3588:
	unset DEVICE_ROOT
	PROJECT=Rockchip DEVICE=RK3588 ARCH=arm ./scripts/build_distro
	PROJECT=Rockchip DEVICE=RK3588 ARCH=aarch64 ./scripts/build_distro

S922X:
	unset DEVICE_ROOT
	PROJECT=Amlogic DEVICE=S922X ARCH=arm ./scripts/build_distro
	PROJECT=Amlogic DEVICE=S922X ARCH=aarch64 ./scripts/build_distro

RK3566:
	DEVICE_ROOT=RK3566 PROJECT=Rockchip DEVICE=RK3566 ARCH=arm ./scripts/build_distro
	DEVICE_ROOT=RK3566 PROJECT=Rockchip DEVICE=RK3566 ARCH=aarch64 ./scripts/build_distro

RK3566-X55:
	DEVICE_ROOT=RK3566 PROJECT=Rockchip DEVICE=RK3566-X55 ARCH=arm ./scripts/build_distro
	DEVICE_ROOT=RK3566 PROJECT=Rockchip DEVICE=RK3566-X55 ARCH=aarch64 ./scripts/build_distro

RK-ARMV8-A:
	unset DEVICE_ROOT
	PROJECT=Rockchip DEVICE=RK-ARMV8-A ARCH=arm ./scripts/build_distro
	PROJECT=Rockchip DEVICE=RK-ARMV8-A ARCH=aarch64 ./scripts/build_distro

RK3326:
	unset DEVICE_ROOT
	PROJECT=Rockchip DEVICE=RK3326 ARCH=arm ./scripts/build_distro
	PROJECT=Rockchip DEVICE=RK3326 ARCH=aarch64 ./scripts/build_distro

RK3399:
	unset DEVICE_ROOT
	PROJECT=Rockchip DEVICE=RK3399 ARCH=arm ./scripts/build_distro
	PROJECT=Rockchip DEVICE=RK3399 ARCH=aarch64 ./scripts/build_distro

update:
	PROJECT=PC DEVICE=AMD64 ARCH=x86_64 ./scripts/update_packages

package:
	./scripts/build ${PACKAGE}

package-clean:
	./scripts/clean ${PACKAGE}

## Docker builds - overview
# docker-* commands just wire up docker to call the normal make command via docker
# For example: make docker-AMD64 will use docker to call: make AMD64
# All variables are scoped to docker-* commands to prevent weird collisions/behavior with non-docker commands

docker-%: DOCKER_IMAGE := "justenoughlinuxos/jelos-build:latest"

# DOCKER_WORK_DIR is the directory in the Docker image - it is set to /work by default
#   Anytime this directory changes, you must run `make clean` similarly to moving the distribution directory
docker-%: DOCKER_WORK_DIR := $(shell if [ -n "${DOCKER_WORK_DIR}" ]; then echo ${DOCKER_WORK_DIR}; else echo "$$(pwd)" ; fi)

# ${HOME}/.JELOS/options is a global options file containing developer and build settings.
docker-%: GLOBAL_SETTINGS := $(shell if [ -f "${HOME}/.JELOS/options" ]; then echo "-v \"${HOME}/.JELOS/options:${HOME}/.JELOS/options\""; else echo ""; fi)

# LOCAL_SSH_KEYS_FILE is a variable that contains the location of the authorized keys file for development build use.  It will be mounted into the container if it exists.
docker-%: LOCAL_SSH_KEYS_FILE := $(shell if [ -n "${LOCAL_SSH_KEYS_FILE}" ]; then echo "-v \"${LOCAL_SSH_KEYS_FILE}:${LOCAL_SSH_KEYS_FILE}\""; else echo ""; fi)

# UID is the user ID of current user - ensures docker sets file permissions properly
docker-%: UID := $(shell id -u)

# GID is the main user group of current user - ensures docker sets file permissions properly
docker-%: GID := $(shell id -g)

# PWD is 'present working directory' and passes through the full path to current dir to docker (becomes 'work')
docker-%: PWD := $(shell pwd)

# Command to use (either `docker` or `podman`)
docker-%: DOCKER_CMD:= $(shell if which docker 2>/dev/null 1>/dev/null; then echo "docker"; elif which podman 2>/dev/null 1>/dev/null; then echo "podman"; fi)

# Podman requires some extra args (`--userns=keep-id` and `--security-opt=label=disable`).  Set those args if using podman
#   Make sure that docker isn't just an alias for podman
docker-%: PODMAN_ARGS:= $(shell if echo "$$(docker --version 2>/dev/null || podman --version 2>/dev/null )" | grep podman 1>/dev/null ; then echo "--userns=keep-id --security-opt=label=disable -v /proc/mounts:/etc/mtab"; fi)

# Launch docker as interactive if this is an interactive shell (allows ctrl-c for manual and running non-interactive - aka: build server)
docker-%: INTERACTIVE=$(shell [ -t 0 ] && echo "-it")

# By default pass through anything after `docker-` back into `make`
docker-%: COMMAND=make $*

# Get .env file ready
docker-%: $(shell env | grep "=" > .env)

# If the user issues a `make docker-shell` just start up bash as the shell to run commands
docker-shell: COMMAND=bash

# Command: builds and pushes a hybrid docker image to dockerhub
# You must login with: docker login --username <username> and provide either a password or token (from user settings -> security in dockerhub) before this will work.  The build user must also be a member of the "docker" group.
docker-image-build:
	$(DOCKER_CMD) buildx create --use
	$(DOCKER_CMD) buildx build --tag $(DOCKER_IMAGE) --platform linux/amd64,linux/arm64 --push .

# Command: pulls latest docker image from dockerhub.  This will *replace* locally built version.
docker-image-pull:
	$(DOCKER_CMD) pull $(DOCKER_IMAGE)

# Wire up docker to call equivalent make files using % to match and $* to pass the value matched by %
docker-%:
	BUILD_DIR=$(DOCKER_WORK_DIR) $(DOCKER_CMD) run $(PODMAN_ARGS) $(INTERACTIVE) --init --env-file .env --rm --user $(UID):$(GID) $(GLOBAL_SETTINGS) $(LOCAL_SSH_KEYS_FILE) -v $(PWD):$(DOCKER_WORK_DIR) -w $(DOCKER_WORK_DIR) $(DOCKER_EXTRA_OPTS) $(DOCKER_IMAGE) $(COMMAND)

