
all: hello-all

# Recall multi-target rules...
africa asia:
	@echo Hello $@

# syntax: $(foreach variable-name,[list],expression-using-variable)
REGIONS := africa asia europe
HELLO-REGIONS := $(foreach REGION,${REGIONS},hello-${REGION})
$(info HELLO-REGIONS is: [${HELLO-REGIONS}])

# hello-all: hello-africa hello-asia hello-europe
hello-all: ${HELLO-REGIONS}

# hello-africa hello-asia hello-europe:
#	@echo $@
${HELLO-REGIONS}:
	@echo $@
