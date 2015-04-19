LIBDIR=/usr/lib/hslm
BINFILE=/usr/bin/hslm
EXECFILE=hslm.lua



default:
	@echo "Run 'make install' to install the program."

install:
	mkdir -p $(LIBDIR)
	cp *.lua $(LIBDIR)
	touch $(BINFILE)
	echo "#!/bin/bash" > $(BINFILE)
	echo "lua $(LIBDIR)/$(EXECFILE)" >> $(BINFILE)
	chmod a+x /usr/bin/hslm
