all:
	@ exit 2

build:
	@ mkdir build || true

vendor: build
	@ mkdir "$$(pwd)/vendor" || true
	@ wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux.tar.gz -O "$$(pwd)/build"
	@ tar xpf "$$(pwd)/vendor/openshift-install-linux.tar.gz" -C "$$(pwd)/build/"