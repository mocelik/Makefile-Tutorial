
# Usage: $(call rwildcard,src,*.c *.h)
rwildcard=$(foreach d,\
	$(wildcard $(1:=/*)), \
	$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

rwildcard=$(wildcard $1$2)\
	$(foreach d,\
	$(wildcard $1*),\
	$(call rwildcard,$d/,$2))
