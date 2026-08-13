STYLES := AIWriting Grammar STE
ZIPS := $(STYLES:%=dist/%.zip)

all: $(ZIPS)

dist/%.zip: %/*.yml
	mkdir -p dist
	rm -f $@
	zip -qr $@ $(@F:.zip=) -x '*.DS_Store'

clean:
	rm -rf dist

.PHONY: all clean
