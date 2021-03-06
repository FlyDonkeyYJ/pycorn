# Disable makepp's builtin rules as they're not particularly cross-compile-y
makepp_no_builtin := 1

include $(ROOT)/config.mk

# Commands
CC := $(PREFIX)gcc
AR := $(PREFIX)ar
OBJCOPY := $(PREFIX)objcopy
PYTHON := hostpython

# Flags
CFLAGS := -g -Wall -O2 -pipe -fomit-frame-pointer -std=gnu99 -Werror
CPPFLAGS :=
CPPDEPS :=
PYCFLAGS := -pipe -fomit-frame-pointer -fno-strict-aliasing -Werror -Wno-error=char-subscripts -Wno-error=unused-function -Wno-error=unused-variable -Wno-error=unused-but-set-variable
LDFLAGS :=
LDDEPS :=

# Get machine-specific stuff
include $(ROOT)/config/$(ARCH)/$(ARCH).mk
include $(ROOT)/config/$(ARCH)/$(MACH).mk

PYTHONVER := 2.7.3
PYTHONVERMINOR := 2.7

# Rules

ifndef USE_BINARIES
%.o: %.c $(prebuild $(CPPDEPS))
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $(input) -o $(output)

%.o: %.S $(prebuild $(CPPDEPS))
	$(CC) $(ASFLAGS) $(CPPFLAGS) -c $(input) -o $(output)

%.o: %.s
	$(CC) $(ASFLAGS) -c $(input) -o $(output)
endif
