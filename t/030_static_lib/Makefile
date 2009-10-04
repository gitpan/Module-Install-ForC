RM=rm
NAME=test
FIRST_MAKEFILE=Makefile
NOECHO=@
TRUE = true
NOOP = $(TRUE)
PERL = /usr/local/bin/perl
VERSION = 0.01
DISTVNAME = $(NAME)-$(VERSION)
PREOP = $(PERL) -I. "-MModule::Install::Admin" -e "dist_preop(q($(DISTVNAME)))"
TO_UNIX = $(NOECHO) $(NOOP)
TAR = tar
TARFLAGS = cvf
RM_RF = rm -rf
COMPRESS = gzip --best
POSTOP = $(NOECHO) $(NOOP)
DIST_DEFAULT = tardist
DIST_CP = best
PERLRUN = $(PERL)

all: libhi.a main

test: 
	prove --exec "/bin/sh -c " 

dist: $(DIST_DEFAULT) $(FIRST_MAKEFILE)

tardist: $(NAME).tar.gz
	$(NOECHO) $(NOOP)

$(NAME).tar.gz: distdir Makefile
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(POSTOP)

distdir:
	$(RM_RF) $(DISTVNAME)
	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \
	    -e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"

clean:
	$(RM) libhi.a main main.o hi.o
	$(RM) Makefile
	/bin/rm -f try try a.out .out try.[cho] try..o core core.try* try.core*

install: all
	

manifest:
	/usr/local/bin/perl -MExtUtils::Manifest -e 'ExtUtils::Manifest::mkmanifest()'

libhi.a: hi.o Makefile
	ar rc libhi.a hi.o
	ranlib libhi.a

hi.o: hi.c Makefile
	gcc    -c -o hi.o hi.c

main: main.o
	cc  -o main main.o -L. -lhi

main.o: main.c Makefile
	gcc    -c -o main.o main.c


