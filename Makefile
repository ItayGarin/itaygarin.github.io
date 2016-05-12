default: build

dev:
	jekyll serve --host=0.0.0.0 -b ""

live:
	gulp

build:
	jekyll build
