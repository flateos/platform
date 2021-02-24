#!make
WORKDIR=/tmp/archiso-tmp
SRC=/arch
OUT=$(SRC)/out
VERSION=$(LOGPATH)$(shell date +%Y.%m.%d)


.PHONY: install

install:
	docker exec -it arch pacman -Syyu --noconfirm && pacman -S archiso --noconfirm

.PHONY: build

build:
	docker exec -it arch mkarchiso -v -w $(WORKDIR) -o $(OUT) $(SRC)

.PHONY: clean

clean:
	docker exec -it arch rm -rf $(WORKDIR)

.PHONY: run

run:
	docker exec -it arch run_archiso -i $(OUT)/archlinux-$(VERSION)-x86_64.iso
