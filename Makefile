.PHONY: all clean debug help release
.ONESHELL:
all: help

help:
	make --print-targets

clean:
	rm -rf bin/

debug: clean
	mkdir bin/
	crystal build src/snipe.cr --progress --debug
	mv snipe bin/

debug-static: clean
	mkdir bin/
	crystal build src/snipe.cr --progress --static --debug
	mv snipe bin/

release: clean
	mkdir bin/
	crystal build src/snipe.cr --progress --release --no-debug
	mv snipe bin/

release-static: clean
	mkdir bin/
	crystal build src/snipe.cr --progress --static --release --no-debug
	mv snipe bin/
