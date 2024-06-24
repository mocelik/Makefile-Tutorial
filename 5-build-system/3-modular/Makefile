
BUILD_DIR := build
SRC_FILES := src/main.c src/dir1/hello.c src/dir2/world.c src/dir2/extra.c src/dir1/com/common.c
OBJ_FILES := $(addprefix ${BUILD_DIR}/,$(patsubst %.c,%.o,${SRC_FILES}))
APP_NAME := ${BUILD_DIR}/steel

.PHONY: all
all:

# $1 -> app name
# $2 -> src files for app
define add_executable_target=
$(call internal_add_executable_target,$1,\
	$(sort $(addprefix ${BUILD_DIR}/,$(patsubst %.c,%.o,${SRC_FILES})))\
	)
endef

# $1 -> app name
# $2 -> object files for app
define internal_add_executable_target=
all: $1
$1: ${BUILD_DIR}/$1
${BUILD_DIR}/$1: $2

$2: ${BUILD_DIR}/%.o : %.c
	$$(info Compiling $$< into $$@)
	gcc $${CDEPS_FLAGS} $${CFLAGS_$1} -c $$< -o $$@

$(foreach OBJ_FILE,$2,$(eval ${OBJ_FILE}: | $(dir ${OBJ_FILE})))
$(sort $(dir ${BUILD_DIR}/$1 $2)):
	mkdir -p $$@

-include $(patsubst %.o,%.d,$2)

clean::
	$${RM} -r ${BUILD_DIR}/$1 $2
endef

$(eval $(call add_executable_target,steel,${SRC_FILES}))

CDEPS_FLAGS := -MMD -MP
CFLAGS_steel := -Wall

clean::
	@echo "Done cleaning"

purge:
	$(if $(filter-out .,${BUILD_DIR}),${RM} -r ${BUILD_DIR},\
		@echo "Cannot purge ${BUILD_DIR}")
