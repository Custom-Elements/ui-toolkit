.PHONY: build test polymer

build: polymer
	bower install
	polymer-build src/ build/

test: polymer
	polymer-build watch . src/ build/

polymer:
	cp node_modules/polymer/layout.* build/
	cp node_modules/polymer/polymer.* build/
	cp node_modules/polymer/platform.* build/

