SHELL:=/bin/bash

# run unit tests
all:
	@shellspec --shell /bin/bash -e BASH__VERBOSE=info

# build merged script
build:
	@echo "Building merged script file..."
	@./build.sh