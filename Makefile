# For supported versions see:
# https://access.redhat.com/support/policy/updates/openshift/#dates
VERSIONS = v4.12 v4.13 v4.14 v4.15 v4.16
# Also update in `.github/workflows/build.yml`!

all: clean $(addsuffix /Dockerfile, $(VERSIONS))

v%/Dockerfile: src/Dockerfile
	./src/release.sh "v$*"

clean:
	rm -rfv v*

images: $(addprefix image/, $(VERSIONS))

image/v%:
	docker build -t local/oc:v$* v$*/

.PHONY: clean images
