
all: info warning error

info:
	$(info Building target info)

warning:
	$(warning Building target warning)

error:
	$(error Building target error)
	$(info You can't see me!)

$(info Even though this info line is at the end of the makefile, it gets \
	printed first. Why?)
${info Note that you can also use braces instead of parentheses}
$(info )
