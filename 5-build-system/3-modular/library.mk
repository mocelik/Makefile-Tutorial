
### Variables ###
################################################################################

ifeq (${BUILD_DIR},)
$(warning BUILD_DIR not set or empty, defaulting to build)
BUILD_DIR := build
endif

ifeq (${LIB_DIR},)
$(warning LIB_DIR not set or empty, defaulting to ${BUILD_DIR}/lib)
LIB_DIR := ${BUILD_DIR}/lib
endif

CDEPS_FLAGS := -MMD -MP

### Functions ###
################################################################################

# $1 -> appname
# Uses:
# 	CSRCS_${appname}
# 	CFLAGS_${appname}
# 	CPPFLAGS_${appname}
# 	LDFLAGS_${appname}
define add_c_library_target=
$(eval COBJS_$1 := $(sort \
	$(addprefix ${BUILD_DIR}/,$(patsubst %.c,%.o,${CSRCS_$1}))))
$(eval LIBNAME_$1 := lib$1.so)

# Add this target to all
all: $1
.PHONY: $1
$1: ${LIB_DIR}/${LIBNAME_$1}

# Rule to Link C
# TODO: Is there any use for ${LDFLAGS_$1} here?
${LIB_DIR}/${LIBNAME_$1}: ${COBJS_$1} | ${LIB_DIR}
	${CC} ${LDFLAGS_$1} -shared $$^ -o $$@

# Rule to Compile C
$(eval CFLAGS_$1 += -fpic)
${COBJS_$1}: ${BUILD_DIR}/%.o : %.c
	${CC} ${CDEPS_FLAGS} ${CFLAGS_$1} ${CPPFLAGS_$1} -c $$< -o $$@

# Rule to create build directory mirror
$(foreach OBJ_FILE,${COBJS_$1},$(eval ${OBJ_FILE}: | $(dir ${OBJ_FILE})))
$(sort $(dir ${COBJS_$1}) ${LIB_DIR}):
	mkdir -p $$@

# Rules (auto-generated) for object dependencies
-include $(patsubst %.o,%.d,${COBJS_$1})

# Rules to clean
.PHONY: clean-$1
clean-$1:
	${RM} -r ${BIN_DIR}/$1 ${COBJS_$1}
endef
