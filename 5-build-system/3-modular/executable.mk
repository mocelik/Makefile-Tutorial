
ifeq (${BUILD_DIR},)
$(warning BUILD_DIR not set or empty, defaulting to build)
BUILD_DIR := build
endif

ifeq (${BIN_DIR},)
$(warning BIN_DIR not set or empty, defaulting to ${BUILD_DIR}/bin)
BIN_DIR := ${BUILD_DIR}/bin
endif

# $1 -> app name
# $2 -> src files for app
# Uses:
# 	CFLAGS_${app name}
# 	LDFLAGS_
define add_executable_target=
$(call internal_add_executable_target,$1,\
	$(sort $(addprefix ${BUILD_DIR}/,$(patsubst %.c,%.o,${2})))\
	)
endef

# $1 -> app name
# $2 -> object files for app
define internal_add_executable_target=
all: $1
$1: ${BIN_DIR}/$1
${BIN_DIR}/$1: $2 | ${BIN_DIR}
	gcc $$^ -o $$@

$2: ${BUILD_DIR}/%.o : %.c
	gcc $${CDEPS_FLAGS} $${CFLAGS_$1} -c $$< -o $$@

$(foreach OBJ_FILE,$2,$(eval ${OBJ_FILE}: | $(dir ${OBJ_FILE})))
$(sort $(dir $2) ${BIN_DIR}):
	mkdir -p $$@

-include $(patsubst %.o,%.d,$2)

.PHONY: clean-$1
clean: clean-$1
clean-$1:
	$${RM} -r ${BUILD_DIR}/$1 $2

endef

### Internal Variables ###
CDEPS_FLAGS := -MMD -MP
