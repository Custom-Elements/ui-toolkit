.PHONY: build test

build:
	bower install
	polymer-build --exclude-polymer src/ build/

test:
	polymer-build --exclude-polymer watch . src/ build/
