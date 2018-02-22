IMAGE_NAME=$(shell basename $(PWD))
TAG=$(shell cat VERSION)
NAMESPACE=$(USER)

.PHONY: build run release install

default: build

build:
	@echo INFO Build image $(NAMESPACE)/$(IMAGE_NAME):$(TAG)
	@docker build -t $(NAMESPACE)/$(IMAGE_NAME):$(TAG) .

run:
	@echo INFO Run docker image
	@docker run -it --rm $(NAMESPACE)/$(IMAGE_NAME):$(TAG)

release:
	@echo INFO Release source archive
	@tar -cvf $(IMAGE_NAME).tar.gz .
