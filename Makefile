STYLES := AIWriting Grammar STE
ZIPS := $(STYLES:%=dist/%.zip)
VALE_DIR := $(HOME)/Library/Application Support/vale

all: $(ZIPS)

# Render the config template and install it. rm first: the target may be a
# symlink from the pre-template layout, and > would write through it into
# the repo.
config: .vale.ini.in
	mkdir -p "$(VALE_DIR)"
	rm -f "$(VALE_DIR)/.vale.ini"
	sed -e 's|@HOME@|$(HOME)|g' -e 's|@REPO@|$(CURDIR)|g' .vale.ini.in > "$(VALE_DIR)/.vale.ini"

dist/%.zip: styles/%/*.yml styles/%/meta.json
	mkdir -p dist
	rm -f $@
	cd styles && zip -qr ../$@ $(@F:.zip=) -x '*.DS_Store'

clean:
	rm -rf dist

.PHONY: all clean config
