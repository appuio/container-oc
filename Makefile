VERSIONS = v3.6 v3.7 v3.9 v3.10 v3.11 v4.1 v4.2 v4.3 v4.4 v4.5

all: clean $(addsuffix /Dockerfile, $(VERSIONS))

v%/Dockerfile: src/Dockerfile
	./src/release.sh "v$*"

clean:
	rm -rfv v*

images: $(addprefix image/, $(VERSIONS))

image/v%:
	docker build -t local/oc:v$* v$*/

.PHONY: clean images
