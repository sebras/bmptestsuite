.PHONY : all clean release

VERSION=0.6

RELEASE_NAME=bmptestsuite-$(VERSION)

PYTHON=python -O -O
TAR=tar
ZIP=zip -r -q -9 -X
TOUCH=touch

all : timestamp

timestamp : bmptestsuite.py Makefile
	$(PYTHON) bmptestsuite.py
	$(TOUCH) timestamp

clean :
	$(RM) *.pyc *~
	$(RM) timestamp


release : all
	rm -rf $(RELEASE_NAME)
	mv bitmaps $(RELEASE_NAME)
	$(TAR) -cj -f $(RELEASE_NAME).tar.bz2 $(RELEASE_NAME)
	$(TAR) -cz -f $(RELEASE_NAME).tar.gz  $(RELEASE_NAME)
	$(ZIP) $(RELEASE_NAME).zip $(RELEASE_NAME)
