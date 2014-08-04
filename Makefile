.PHONY: build test

build:
	bower install
	polymer-build --exclude-polymer src/ build/
	polymer-build ./ ~/tmp demo.html

test: build
	polymer-build watch . src/ build/
