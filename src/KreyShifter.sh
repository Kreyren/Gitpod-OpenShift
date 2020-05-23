#!/bin/sh
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> under GPLv3 <https://www.gnu.org/licenses/gpl-3.0.en.html> in 23/05/2020 14:40 CET

###! Proof of concept script that sets up gitpod on OpenShift
###! Checklist:
###! - [ ] Download the installer
###!  - [ ] Relase version - https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux.tar.gz
###!  - [ ] Developer preview verison - https://cloud.redhat.com/openshift/install/pre-release
###! - [ ] Cache the installer
###! - [ ] Extract the installer from cache
###! - [ ] TODO

# WARNING: This is a quick script!! DO NOT RUN!
exit 1

myName="KreyShifter"
targetDir="$HOME/gitpod-openshift"
cacheDir="$HOME/.cache/$myName"

wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux.tar.gz -O "$cacheDir/openshift-install-linux.tar.gz"

# Extract in targetDir
tar xpf "$cacheDir/openshift-install-linux.tar.gz" -C "$targetDir"

# Set executable perm
chmod +x "$targetDir/openshift-install"

clusterName="gitpod"

# FIXME: Generate clounds.yaml
cat <<-EOF > "$targetDir/clouds.yaml"
  clouds:
  $clusterName:
    auth:
      auth_url: http://10.10.14.42:5000/v3
      project_name: $clusterName
      username: $clusterName_user
      password: passw0rd
      user_domain_name: Default
      project_domain_name: Default
  dev-env:
    region_name: RegionOne
    auth:
      username: '$clusterName_devuser'
      password: passw0rd
      project_name: '$clusterName_devuser'
      auth_url: 'https://10.10.14.22:5001/v2.0'
EOF

# Run the thing
"$targetDir/openshift-install"