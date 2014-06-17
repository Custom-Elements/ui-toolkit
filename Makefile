.PHONY: build test polymer

build: polymer
	bower install
	polymer-build --exclude-polymer src/ build/

test: polymer
	polymer-build --exclude-polymer watch . src/ build/

polymer:
	[ -d build ] || mkdir build
	cp node_modules/polymer/layout.* build/
	cp node_modules/polymer/polymer.* build/
	cp node_modules/polymer/platform.* build/

