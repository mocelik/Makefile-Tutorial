
# Recall multi-target rules...
lion tiger:
	@echo Hello $@

# syntax: $(foreach variable-name,[list],expression-using-variable)
PLANETS := $(foreach planet,mercury venus earth mars jupiter saturn uranus neptune pluto,hello-$(planet))
$(info PLANETS is: [$(PLANETS)])

# hello-all: hello-mercury hello-venus hello-earth ...
hello-all: $(PLANETS)

# hello-mercury:
#	@echo hello-mercury
#
# hello-venus:
#	@echo hello-venus
# ...
$(PLANETS):
	@echo $@
