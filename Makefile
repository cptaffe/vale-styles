STYLES := AIWriting Grammar STE
ZIPS := $(STYLES:%=dist/%.zip)

all: $(ZIPS)

dist/%.zip: styles/%/*.yml styles/%/meta.json
	mkdir -p dist
	rm -f $@
	cd styles && zip -qr ../$@ $(@F:.zip=) -x '*.DS_Store'

clean:
	rm -rf dist

.PHONY: all clean
