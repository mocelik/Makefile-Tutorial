include common.mk

### Functions ###
################################################################################

# $1 -> library name (e.g. 'x' for 'libx.so')
# Uses:
# 	${LIB_DIR}
# 	${CSRCS_$1}
# 	${CFLAGS_$1}
# 	${CPPFLAGS_$1}
# 	${LDFLAGS_$1}
# 	${DEPS_$1}
# 	${HEADER_DIR_$1}
define add_c_library_target=

$(eval LIBNAME_$1 := lib$1.so)

# Add this target to all
all: $1
.PHONY: $1
$1: ${LIB_DIR}/${LIBNAME_$1}

# Rule to Compile C
$(eval CFLAGS_$1 += -fpic)
$(eval $(call add_c_compile_target,$1))

# Rule to Link C to shared object and publish headers
# TODO: Is there any use for ${LDFLAGS_$1} here?
$(eval LDFLAGS_$1 += -shared)
${LIB_DIR}/${LIBNAME_$1}: ${COBJS_$1} ${DEPS_$1} | ${LIB_DIR}
	${CC} ${LDFLAGS_$1} -shared ${COBJS_$1} -o $$@
	cp -r ${HEADER_DIR_$1} ${INC_DIR}


# Rules to clean
.PHONY: clean-$1
clean-$1:
	${RM} -r ${LIB_DIR}/${LIBNAME_$1} ${COBJS_$1} ${INC_DIR}/${HEADER_DIR_$1}
endef
