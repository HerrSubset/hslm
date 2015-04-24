LIBDIR=/usr/lib
BINFILE=/usr/bin/hslm
EXECFILE=hslm.lua
LUA= $(shell echo `which lua`)
LUA_BINDIR= $(shell echo `dirname $(LUA)`)
LUA_PREFIX= $(shell echo `dirname $(LUA_BINDIR)`)
LUA_VERSION = $(shell echo `lua -v 2>&1 | cut -d " " -f 2 | cut -b 1-3`)
LUA_SHAREDIR=$(LUA_PREFIX)/share/lua/$(LUA_VERSION)


default:
	@echo "Run 'make install' to install the program."

install:
	cp $(EXECFILE) $(LIBDIR)
	touch $(BINFILE)
	echo "#!/bin/bash" > $(BINFILE)
	echo "lua $(LIBDIR)/$(EXECFILE)" >> $(BINFILE)
	chmod a+x $(BINFILE)

	cp db.lua shopListManager.lua $(LUA_SHAREDIR)
