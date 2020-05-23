all:
	$(error Invalid argument)
	@ exit 2

vendor:
	@ [ -d vendor ] || mkdir vendor
	@ [ -e vendor/openshift-install-linux.tar.gz ] || wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux.tar.gz -O vendor/openshift-install-linux.tar.gz

build: vendor
	@ [ -d build ] || mkdir build
	@ tar xpf "$$(pwd)/vendor/openshift-install-linux.tar.gz" -C "$$(pwd)/build/"
	@ [ -x build/openshift-install ] || chmod +x build/openshift-install
	@ build/openshift-install create cluster

clean:
	@ [ ! -d build ] || rm -r build
	@ [ ! -d vendor ] || rm -r vendor