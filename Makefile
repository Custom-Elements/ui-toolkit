.PHONY: build test

POLYMER_BUILD="./node_modules/.bin/polymer-build"
BOWER="./node_modules/.bin/bower"

build:
	${BOWER} install
	${POLYMER_BUILD} --exclude-polymer --compress src/ build/
	${POLYMER_BUILD} --exclude-polymer src/ build_debug/
	${POLYMER_BUILD} ./ ~/tmp demo.html

test:
	${POLYMER_BUILD} watch . src/ build/
