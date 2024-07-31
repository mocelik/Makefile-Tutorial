include common.mk

### Functions ###
################################################################################

# $1 -> appname
# Uses:
# 	${BUILD_DIR}
# 	${CSRCS_$1}
# 	${CFLAGS_$1}
# 	${CPPFLAGS_$1}
# 	${LDFLAGS_$1}
# 	${LDLIBS_$1}
# 	${DEPS_$1}
define add_c_executable_target=

# Add this target to all
all: $1
.PHONY: $1
$1: ${BIN_DIR}/$1

# Each object should individually depend on DEPS_$1
# E.g. if there is a dependency on a library, each object depends on the header
# files that will be created from that library
${COBJS_$1}: ${DEPS_$1}

$(eval $(call add_c_compile_target,$1))

# Rule to Link C
${BIN_DIR}/$1: ${COBJS_$1} ${DEPS_$1} | ${BIN_DIR}
	${CC} ${LDFLAGS_$1} ${COBJS_$1} -o $$@ ${LDLIBS_$1}

# Rules to clean
.PHONY: clean-$1
clean-$1:
	${RM} -r ${BIN_DIR}/$1 ${COBJS_$1}
endef
