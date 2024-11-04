# Path macros
BUILD_DIR = build
# File macros
ENTRYPOINT = snipe.cr

default: build

.PHONY: build
build: clean
	mkdir ${BUILD_DIR}
	cp -r shard.yml src lib ${BUILD_DIR}
	cd ${BUILD_DIR}; crystal build src/${ENTRYPOINT}

.PHONY: clean
clean:
	rm -rf ${BUILD_DIR}
