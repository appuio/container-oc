VERSIONS = v4.1 v4.2 v4.3 v4.4 v4.5 v4.6 v4.7 v4.8 v4.9

all: clean $(addsuffix /Dockerfile, $(VERSIONS))

v%/Dockerfile: src/Dockerfile
	./src/release.sh "v$*"

clean:
	rm -rfv v*

images: $(addprefix image/, $(VERSIONS))

image/v%:
	docker build -t local/oc:v$* v$*/

.PHONY: clean images
