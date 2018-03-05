IMAGE_NAME=$(shell basename $(PWD))
TAG=$(shell cat VERSION)
NAMESPACE=$(USER)

.PHONY: build run release install clean test

default: build

build:
	@echo INFO Build image $(NAMESPACE)/$(IMAGE_NAME):$(TAG)
	@docker build -t $(NAMESPACE)/$(IMAGE_NAME):$(TAG) .

run:
	@echo INFO Run docker image
	@docker run -it --rm $(NAMESPACE)/$(IMAGE_NAME):$(TAG)

release:
	@echo INFO Release source archive
	mkdir -p ./dist
	tar -cvf dist/$(IMAGE_NAME).tar.gz .

clean:
	@echo INFO Clean archive
	rm -r ./dist

install:
	@echo INFO Install $(IMAGE_NAME)
	mkdir -p $(HOME)/.vim/packs/plugins/start/
	cp -R $(PWD) $(HOME)/.vim/packs/plugins/start/

test:
	@echo INFO Test $(IMAGE_NAME)
	vim -c "redir > vim.output | silent call testing#test() | redir END | q!" 
