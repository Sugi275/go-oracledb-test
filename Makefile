GO15VENDOREXPERIMENT = 1
OSXCROSS_NO_INCLUDE_PATH_WARNINGS = 1

NAME	 := go-oracledb-test
TARGET	 := bin/$(NAME)
DIST_DIRS := find * -type d -exec
SRCS	:= $(shell find . -type f -name '*.go')

$(TARGET): $(SRCS)
	go build -o bin/$(NAME) src/${NAME}.go

.PHONY: clean
clean:
	rm -rf bin/*

.PHONY: run
run:
	go run src/$(NAME).go

.PHONY: deps
dep:
	dep ensure

.PHONY: dep-install
dep-install:
	go get -u github.com/golang/dep/cmd/dep

.PHONY: lint
lint:
	golint src/${NAME}.go

.PHONY: golint-install
golint-install:
	go get -u golang.org/x/lint/golint

.PHONY: docker-build
docker-build:
	docker build -t cndjp/$(NAME):$(DOCKER_IMAGE_TAG) .

.PHONY: cross-build
cross-build: deps
	for os in darwin linux windows; do \
		for arch in amd64 386; do \
			GOOS=$$os GOARCH=$$arch CGO_ENABLED=0 go build -a -tags netgo -installsuffix netgo $(LDFLAGS) -o dist/$(NAME)-$$os-$$arch/$(NAME); \
		done; \
	done

.PHONY: dist
dist:
	cd dist && \
		$(DIST_DIRS) cp ../LICENSE {} \; && \
		$(DIST_DIRS) cp ../README.md {} \; && \
		$(DIST_DIRS) tar -zcf {}-$(VERSION).tar.gz {} \; && \
		$(DIST_DIRS) zip -r {}-$(VERSION).zip {} \; && \
		cd ..
