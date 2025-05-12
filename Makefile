.PHONY: all clean debug help release
.ONESHELL:
all: help

clean:
	rm -rf bin/

debug: clean
	mkdir bin/
	crystal build src/snipe.cr --progress --debug
	mv snipe bin/

help:
	make --print-targets

release: clean
	mkdir bin/
	crystal build src/snipe.cr --progress --release --no-debug
	mv snipe bin/
