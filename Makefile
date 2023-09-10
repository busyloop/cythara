export UNAME := $(shell uname -sm | sed 's/ /-/' | tr '[:upper:]' '[:lower:]')
export MAKE_UNAME := $(shell uname -sm | sed 's/ /_/' | tr '[:lower:]' '[:upper:]')
export VERSION := $(shell grep "^version" shard.yml | cut -d ' ' -f 2)

SRC_FILES = $(shell find src)
CRYSTAL ?= crystal
CRYSTAL_SPEC_ARGS = --fail-fast --order random

CRYSTAL_ARGS_LOCAL_DARWIN_X86_64   = --progress
CRYSTAL_ARGS_LOCAL_LINUX_X86_64    = --progress
CRYSTAL_ARGS_LOCAL_LINUX_AARCH64   = --progress
CRYSTAL_ARGS_RELEASE_DARWIN_X86_64 = --release --no-debug
CRYSTAL_ARGS_RELEASE_LINUX_X86_64  = --static --release --no-debug
CRYSTAL_ARGS_RELEASE_LINUX_AARCH64 = --static --release --no-debug

.PHONY: init release docs

lint_and_test: lint test

test:
	$(CRYSTAL) spec $(CRYSTAL_SPEC_ARGS)

lint: bin/ameba
	bin/ameba

bin/ameba:
	shards install

ci:
	shards install --without-development
	$(MAKE) lint_and_test

clean:
	# Nothing to clean. This is a library.

release:
	# Nothing to build. This is a library.

github_release:
	@git diff --quiet -- . :^shard.yml :^docs || { echo "Commit your changes (except docs/ and shard.yml) first." ; exit 1; }
	@[ ! $$(git tag -l "v$(VERSION)") ] || { echo "Tag v$(VERSION) already exists." ; exit 1; }
	$(MAKE) lint_and_test
	$(MAKE) docs
	git add docs && git commit -q -m "v$(VERSION)" docs || true
	git commit -q -m "v$(VERSION)" shard.yml || true
	git tag v$(VERSION) && git push --atomic origin master v$(VERSION)

version:
	@echo $(VERSION)

docs:
	@crystal doc --project-version=v$(VERSION)
