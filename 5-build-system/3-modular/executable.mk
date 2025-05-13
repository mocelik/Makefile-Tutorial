include common.mk

### Functions ###
################################################################################

# $1 -> appname
# Uses:
# 	${CSRCS_$1}
# 	${CFLAGS_$1}
# 	${CPPFLAGS_$1}
# 	${LDFLAGS_$1}
# 	${LDLIBS_$1}
# 	${DEPS_$1}
# Sets:
#	${COBJS_$1}
define add_c_executable_target=

$(eval APPNAME_$1 := ${BIN_DIR}/$1)

.PHONY: $1
all: $1
$1: ${APPNAME_$1}

$(eval $(call add_c_compile_target,$1))

# Rule to Link C
${APPNAME_$1}: ${COBJS_$1} ${DEPS_$1} | ${BIN_DIR}
	${CC} ${LDFLAGS_$1} ${COBJS_$1} -o $$@ ${LDLIBS_$1}

$(eval $(call add_clean_target,$1,${APPNAME_$1} ${COBJS_$1}))
endef
