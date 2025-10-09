#!/usr/bin/bash
set -xeuo pipefail

dnf5 install -y \
  zsh

# Restore UUPD update timer and Input Remapper
sed -i 's@^NoDisplay=true@NoDisplay=false@' /usr/share/applications/input-remapper-gtk.desktop
systemctl enable input-remapper.service
systemctl enable uupd.timer

# Remove -deck specific changes to allow for login screens
rm -f /etc/sddm.conf.d/steamos.conf
rm -f /etc/sddm.conf.d/virtualkbd.conf
rm -f /usr/share/gamescope-session-plus/bootstrap_steam.tar.gz
systemctl disable bazzite-autologin.service

dnf5 install --enable-repo="copr:copr.fedorainfracloud.org:ublue-os:packages" -y \
  ublue-setup-services

docker_pkgs=(
  containerd.io
  docker-buildx-plugin
  docker-ce
  docker-ce-cli
  docker-compose-plugin
)

dnf5 config-manager addrepo --from-repofile="https://download.docker.com/linux/fedora/docker-ce.repo"
dnf5 config-manager setopt docker-ce-stable.enabled=0
dnf5 install -y --enable-repo="docker-ce-stable" "${docker_pkgs[@]}" || {
  # Use test packages if docker pkgs is not available for f42
  if (($(lsb_release -sr) == 42)); then
    echo "::info::Missing docker packages in f42, falling back to test repos..."
    dnf5 install -y --enablerepo="docker-ce-test" "${docker_pkgs[@]}"
  fi
}

# Load iptable_nat module for docker-in-docker.
# See:
#   - https://github.com/ublue-os/bluefin/issues/2365
#   - https://github.com/devcontainers/features/issues/1235
mkdir -p /etc/modules-load.d && cat >>/etc/modules-load.d/ip_tables.conf <<EOF
iptable_nat
EOF
