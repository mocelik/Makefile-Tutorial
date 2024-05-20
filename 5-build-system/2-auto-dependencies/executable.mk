
ifndef SOURCE_FILES
$(error SOURCE_FILES must be set to a list of source files to compile)
endif

ifndef EXECUTABLE_NAME
$(error EXECUTABLE_NAME must be set to target executable name)
endif

ifndef CFLAGS
$(error CFLAGS must be set to flags for this executable)
endif

ifndef CONFIG
$(error CONFIG must be set to debug or release)
endif

ifndef BUILD_DIR
$(error BUILD_DIR must be set to a directory to store artifacts in)
endif

OBJECT_FILES := $(addprefix ${BUILD_DIR}/,$(patsubst %.cpp,%.o,${SOURCE_FILES}))
OBJECT_DIRECTORY_MIRROR := $(sort $(dir ${OBJECT_FILES})) # sort gives uniques

${OBJECT_DIRECTORY_MIRROR}:
	mkdir -p $@

$(foreach obj,${OBJECT_FILES},\
	$(eval ${obj}: | $(dir ${obj})))

${BUILD_DIR}:
	@mkdir -p $@

${BUILD_DIR}/${EXECUTABLE_NAME}: ${OBJECT_FILES} | ${BUILD_DIR}
	$(CXX) -o $@ $^

${OBJECT_FILES}: ${BUILD_DIR}/%.o : %.cpp
	$(CXX) -c $< -o $@ 

clean::
	$(RM) -r ${OBJECT_FILES} ${BUILD_DIR}/${EXECUTABLE_NAME}
