#!/usr/bin/env bash
set -e

sudo pacman -S --needed --noconfirm $(< packages/pacman.txt)

if ! command -v yay &>/dev/null; then
  git clone https://aur.archlinux.org/yay.git
  cd yay && makepkg -si --noconfirm
  cd ..
fi

yay -S --needed --noconfirm $(< packages/aur.txt)

mkdir -p ~/.config ~/.local/bin ~/.config-backup
cp -r ~/.config/* ~/.config-backup 2>/dev/null || true

cp -r configs/* ~/.config/
cp -r bin/* ~/.local/bin/
chmod +x ~/.local/bin/*

walset || true
