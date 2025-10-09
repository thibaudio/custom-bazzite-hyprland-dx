# Bazzite DX - Hyprland Edition

[![Build Bazzite Hyprland DX](https://github.com/thibaudio/custom-bazzite-hyprland-dx/actions/workflows/build.yml/badge.svg)](https://github.com/thibaudio/custom-bazzite-hyprland-dx/actions/workflows/build.yml)

This is a custom image, forked from [Bazzite DX](https://github.com/ublue-os/bazzite-dx), with the following changes:
- \- KDE
- \- VSCode
- \+ kitty
- \+ Hyprland
- \+ Waybar
- \+ Wofi

## Installation
To rebase an existing Bazzite installation to this image, use one of the following commands based on your current variant:

```bash
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/thibaudio/bazzite-hyprland-dx:stable
```

### NVIDIA Variants
```bash
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/thibaudio/bazzite-hyprland-dx-nvidia:stable
```
