# Path macros
BUILD_DIR := build
PATCHES_DIR := patches
# File macros
ENTRYPOINT := snipe.cr
PATCHES := $(wildcard ${PATCHES_DIR}/*.patch)

default: build

.ONESHELL:

.PHONY: build
build: clean
	mkdir ${BUILD_DIR}
	cp -r  ${PATCHES_DIR} shard.yml src lib  ${BUILD_DIR}

	cd ${BUILD_DIR}
	$(foreach patch_file,$(PATCHES),patch -p0 < $(patch_file);)
	crystal build src/${ENTRYPOINT}

.PHONY: clean
clean:
	rm -rf ${BUILD_DIR}
