# Makefile for the faulting user space programs

all		: apps
clean		: clean_apps

CC = $(CROSS_COMPILE_APPS)gcc
CFLAGS		:= -Os -mcpu=cortex-m3 -mthumb -I$(INSTALL_ROOT)/A2F/root/usr/include
LDFLAGS		:= -mcpu=cortex-m3 -mthumb -L$(INSTALL_ROOT)/A2F/root/usr/lib -static

# Edit the line below to modify a set of user-space programs
# you need to build
APPS		= t1 t2 t3 t4
apps		: $(APPS)

%.o:		%.c
	$(CC) -c $(CFLAGS) -o $@ $^

# Clean-up after user-space programs
clean_apps	:
	-rm -f $(APPS) *.gdb *.o
