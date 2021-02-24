#!make

.PHONY: install

install:
	sudo pacman -Syu --noconfirm && sudo pacman -S archiso --noconfirm

.PHONY: build

build:
	sudo mkarchiso -v -w /tmp/archiso-tmp $(PWD)

.PHONY: clean

clean:
	sudo rm -rf /tmp/archiso-tmp

.PHONY: run

run:
	run_archiso -i /usr/live/out/archlinux-$(date +%Y.%m.%d)-x86_64.iso
