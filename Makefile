.PHONY : all clean release release-binary release-source

PYTHON=python -O
TAR=tar
ZIP=zip -r -q -9 -X
TOUCH=touch

VERSION=0.7+

RELEASE_NAME        = bmptestsuite-$(VERSION)
SOURCE_RELEASE_NAME = bmptestsuite-src-$(VERSION)

SRCS += Makefile
SRCS += bmptestsuite.py
SRCS += COPYING
SRCS += ChangeLog
SRCS += README

all : bitmaps.timestamp

# build the set of test bitmaps
bitmaps.timestamp : $(SRCS)
	$(PYTHON) bmptestsuite.py
	$(TOUCH) bitmaps.timestamp

# erase all non-source files
clean :
	$(RM) *.pyc *~
	$(RM) *.timestamp
	$(RM) -r bitmaps

# erase all files created by the "release" target
distclean :
	$(RM) -r bmptestsuite-?.*
	$(RM) -r bmptestsuite-src-?.*


release : release-source release-binary ;

#
# a binary release
#
BINARY_RELEASES += $(RELEASE_NAME).tar.gz
BINARY_RELEASES += $(RELEASE_NAME).tar.bz2
BINARY_RELEASES += $(RELEASE_NAME).zip

$(BINARY_RELEASES) : all

release-binary : $(BINARY_RELEASES)
	rm -rf $(RELEASE_NAME)
	cp --recursive bitmaps $(RELEASE_NAME)
	cp COPYING $(RELEASE_NAME)
	cp README  $(RELEASE_NAME)
	$(TAR) -cj -f $(RELEASE_NAME).tar.bz2 $(RELEASE_NAME)
	$(TAR) -cz -f $(RELEASE_NAME).tar.gz  $(RELEASE_NAME)
	$(ZIP) $(RELEASE_NAME).zip $(RELEASE_NAME)

#
# a source release
#
SOURCE_RELEASES += $(SRC_RELEASE_NAME).tar.gz 
SOURCE_RELEASES += $(SRC_RELEASE_NAME).tar.bz2
SOURCE_RELEASES += $(SRC_RELEASE_NAME).zip

$(SOURCE_RELEASES) : $(SRCS)

release-source : $(SOURCE_RELEASES)
	rm -rf $(SOURCE_RELEASE_NAME)
	mkdir $(SOURCE_RELEASE_NAME)
	cp $(SRCS) $(SOURCE_RELEASE_NAME)
	$(TAR) -cj -f $(SOURCE_RELEASE_NAME).tar.bz2 $(SOURCE_RELEASE_NAME)
	$(TAR) -cz -f $(SOURCE_RELEASE_NAME).tar.gz  $(SOURCE_RELEASE_NAME)
	$(ZIP) $(SOURCE_RELEASE_NAME).zip $(SOURCE_RELEASE_NAME)
