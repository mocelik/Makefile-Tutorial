
ifndef _COMMON_MK_INCLUDED_
_COMMON_MK_INCLUDED_ := INCLUDED

BUILD_DIR ?= build
BIN_DIR ?= ${BUILD_DIR}/bin
LIB_DIR ?= ${BUILD_DIR}/lib
INC_DIR ?= ${BUILD_DIR}/include

${BUILD_DIR} ${BIN_DIR} ${LIB_DIR} ${INC_DIR}:
	@mkdir -p $@

### Functions ###
################################################################################

# $1 -> Module name
# Uses:
#	${CSRCS_$1}
# 	${CFLAGS_$1}
# 	${CPPFLAGS_$1}
#	${DEPS_$1}
# Sets:
#	${COBJS_$1}
define add_c_compile_target=

# ${CSRCS_$1} is a space separated list of source files
# Generate ${COBJS_$1} for the corresponding object files in the build directory
$(eval COBJS_$1 := $(sort \
	$(addprefix ${BUILD_DIR}/,$(patsubst %.c,%.o,${CSRCS_$1}))))

# Each object should individually depend on DEPS_$1
# E.g. if there is a dependency on a library, each object depends on the header
# files that will be created from that library
${COBJS_$1}: ${DEPS_$1}

# Static Pattern Rule to Compile C source file
# Note the -MMD -MP flags so the compiler will generate Makefiles with
# incremental build dependencies defined within
${COBJS_$1}: ${BUILD_DIR}/%.o : %.c
	${CC} -MMD -MP ${CFLAGS_$1} ${CPPFLAGS_$1} -c $$< -o $$@

# Make the build directory mirror the source directory
# Every object must have an order-only prerequisite on its own directory
$(foreach OBJ_FILE,${COBJS_$1},$(eval ${OBJ_FILE}: | $(dir ${OBJ_FILE})))

# Every directory must have a rule to create it
# Eliminate duplicate directories by sorting
$(sort $(dir ${COBJS_$1})):
	@mkdir -p $$@

# Include the automatically generated dependency files for incremental builds
-include $(patsubst %.o,%.d,${COBJS_$1})

endef

# $1 -> Name of module to clean
# $2 -> List of files/directories to delete
# Sets:
#	${ARTIFACTS_$1}	- $2 is appended
define add_clean_target=
$(eval ARTIFACTS_$1 += $2)
.PHONY: clean-$1
clean-$1:
	${RM} -r ${ARTIFACTS_$1}
endef

endif # ifndef _COMMON_MK_INCLUDED_
