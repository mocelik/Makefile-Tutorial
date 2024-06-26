
ifeq (${BUILD_DIR},)
$(warning BUILD_DIR not set or empty, defaulting to build)
BUILD_DIR := build
endif

ifeq (${BIN_DIR},)
$(warning BIN_DIR not set or empty, defaulting to ${BUILD_DIR}/bin)
BIN_DIR := ${BUILD_DIR}/bin
endif

# $1 -> appname
# Uses:
# 	CSRCS_${appname}
# 	CFLAGS_${appname}
# 	LDFLAGS_${appname}
# 	LDLIBS_${appname}
define add_executable_target=
$(eval COBJS_$1 := $(sort \
	$(addprefix ${BUILD_DIR}/,$(patsubst %.c,%.o,${CSRCS_$1}))))
$(call internal_add_executable_target,$1)
endef

# $1 -> app name
# $2 -> object files for app
define internal_add_executable_target=
all: $1
.PHONY: $1
$1: ${BIN_DIR}/$1
${BIN_DIR}/$1: ${COBJS_$1} | ${BIN_DIR}
	${CC} ${LDFLAGS_$1} $$^ -o $$@ ${LDLIBS_$1}

${COBJS_$1}: ${BUILD_DIR}/%.o : %.c
	${CC} ${CDEPS_FLAGS} ${CFLAGS_$1} ${CPPFLAGS_$1} -c $$< -o $$@

$(foreach OBJ_FILE,${COBJS_$1},$(eval ${OBJ_FILE}: | $(dir ${OBJ_FILE})))
$(sort $(dir ${COBJS_$1}) ${BIN_DIR}):
	mkdir -p $$@

-include $(patsubst %.o,%.d,${COBJS_$1})

.PHONY: clean-$1
clean: clean-$1
clean-$1:
	${RM} -r ${BUILD_DIR}/$1 ${COBJS_$1}

endef

### Internal Variables ###
CDEPS_FLAGS := -MMD -MP
