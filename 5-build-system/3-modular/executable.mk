
### Variables ###
################################################################################

ifeq (${BUILD_DIR},)
$(warning BUILD_DIR not set or empty, defaulting to build)
BUILD_DIR := build
endif

ifeq (${BIN_DIR},)
$(warning BIN_DIR not set or empty, defaulting to ${BUILD_DIR}/bin)
BIN_DIR := ${BUILD_DIR}/bin
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
# 	LDLIBS_${appname}
#	DEPS_${appname}
define add_c_executable_target=
$(eval COBJS_$1 := $(sort \
	$(addprefix ${BUILD_DIR}/,$(patsubst %.c,%.o,${CSRCS_$1}))))

# Add this target to all
all: $1
.PHONY: $1
$1: ${BIN_DIR}/$1

# Rule to Link C
${BIN_DIR}/$1: ${COBJS_$1} ${DEPS_$1} | ${BIN_DIR}
	${CC} ${LDFLAGS_$1} ${COBJS_$1} -o $$@ ${LDLIBS_$1}

# Each object should individually depend on DEPS_$1
# E.g. if there is a dependency on a library, each object depends on the header
# files that will be created from that library
${COBJS_$1}: ${DEPS_$1}

# Rule to Compile C
${COBJS_$1}: ${BUILD_DIR}/%.o : %.c
	${CC} ${CDEPS_FLAGS} ${CFLAGS_$1} ${CPPFLAGS_$1} -c $$< -o $$@

# Rule to create build directory mirror
$(foreach OBJ_FILE,${COBJS_$1},$(eval ${OBJ_FILE}: | $(dir ${OBJ_FILE})))
$(sort $(dir ${COBJS_$1}) ${BIN_DIR}):
	mkdir -p $$@

# Rules (auto-generated) for object dependencies
-include $(patsubst %.o,%.d,${COBJS_$1})

# Rules to clean
.PHONY: clean-$1
clean-$1:
	${RM} -r ${BIN_DIR}/$1 ${COBJS_$1}
endef
