.PHONY: build test

build:
	bower install
	polymer-build --exclude-polymer src/ build/
	[ -d build ] || mkdir build
	cp node_modules/polymer/layout.* build/
	cp node_modules/polymer/polymer.* build/
	cp node_modules/polymer/platform.* build/

test:
	polymer-build --exclude-polymer watch . src/ build/
