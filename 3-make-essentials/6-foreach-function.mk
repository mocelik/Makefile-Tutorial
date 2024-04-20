
all: hello-all

# Recall multi-target rules...
lion tiger:
	@echo Hello $@

# syntax: $(foreach variable-name,[list],expression-using-variable)
PLANETS := mercury venus earth mars jupiter saturn uranus neptune pluto
HELLO-PLANETS := $(foreach planet,${PLANETS},hello-${planet})
$(info HELLO-PLANETS is: [${HELLO-PLANETS}])

# hello-all: hello-mercury hello-venus hello-earth ...
hello-all: ${HELLO-PLANETS}

# hello-mercury:
#	@echo hello-mercury
#
# hello-venus:
#	@echo hello-venus
# ...
${HELLO-PLANETS}:
	@echo $@
