#!make
WORKDIR=/tmp/archiso-tmp
SRC=/arch
OUT=/arch/out


.PHONY: install

install:
	docker exec -it arch pacman -Syyu --noconfirm && pacman -S archiso --noconfirm

.PHONY: build

build:
	docker exec -it arch mkarchiso -v -w $(WORKDIR) $(SRC)

.PHONY: clean

clean:
	docker exec -it arch rm -rf $(WORKDIR)

.PHONY: run

run:
	docker exec -it arch run_archiso -i ${OUT}/archlinux-$(date +%Y.%m.%d)-x86_64.iso
