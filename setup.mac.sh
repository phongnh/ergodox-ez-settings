#!/usr/bin/env bash
mkdir -p ~/src
cd ~/src
if [ -d qmk_firmware ]; then
    cd qmk_firmware ; git fetch -p ; git reset --hard origin/HEAD
else
    git clone https://github.com/qmk/qmk_firmware.git
    cd qmk_firmware && git submodule update --init --recursive
fi

MY_KEYMAP="$HOME/src/qmk_firmware/keyboards/ergodox_ez/keymaps/$(whoami)"
if [ -d "$MY_KEYMAP" ]; then
    cd "$MY_KEYMAP" ; git fetch -p ; git reset --hard origin/HEAD
else
    git clone https://github.com/phongnh/ergodox-ez-settings.git "$MY_KEYMAP"
fi

brew install teensy_loader_cli
# brew cask install teensy

brew tap osx-cross/avr
brew install avr-libc
brew install dfu-programmer

cd ~/src/qmk_firmware
make ergodox_ez-`whoami`-clean ez-`whoami`-teensy
