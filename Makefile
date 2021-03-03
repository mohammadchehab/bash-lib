SHELL:=/bin/bash

# run unit tests
all:
	@shellspec --shell /bin/bash -e BASH__VERBOSE=info
