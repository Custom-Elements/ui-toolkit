.PHONY: build test

build:
	bower install
	polymer-build --exclude-polymer src/ build/
	polymer-build ./ ~/tmp demo.html

test:
	polymer-build --exclude-polymer watch . src/ build/
