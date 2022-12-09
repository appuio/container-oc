VERSIONS = v4.8 v4.9 v4.10 v4.11

all: clean $(addsuffix /Dockerfile, $(VERSIONS))

v%/Dockerfile: src/Dockerfile
	./src/release.sh "v$*"

clean:
	rm -rfv v*

images: $(addprefix image/, $(VERSIONS))

image/v%:
	docker build -t local/oc:v$* v$*/

.PHONY: clean images
