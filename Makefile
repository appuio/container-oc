VERSIONS = $(notdir $(wildcard src/versions/*))

all: clean $(addsuffix /Dockerfile, $(VERSIONS))

v%/Dockerfile: src/Dockerfile
	mkdir -p v$*
	sed -f src/versions/v$* src/Dockerfile > v$*/Dockerfile

clean:
	rm -rfv v*

.PHONY: clean
