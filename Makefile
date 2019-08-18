# FILE. . . . . /home/hak/hlt/src/hlt/language/design/Makefile
# EDIT BY . . . Hassan Ait-Kaci
# ON MACHINE. . Hp-Dv7
# STARTED ON. . Tue Jul 31 00:30:02 2012

########################################################################

# @version     Last modified on Wed Mar 23 16:58:51 2016 by hak
# @author      <a href="mailto:hak@acm.org">Hassan A&iuml;t-Kaci</a>
# @copyright   &copy; <a href="http://www.hassan-ait-kaci.net/">by the author</a>

########################################################################
CLASSPATH	= $(HLT_HOME)/classes
PACKMAIN	= hlt
PACKPREF1	= language
PACKPREF2	= design
DIRFIX		= 
PACKPREF	= $(PACKMAIN).$(PACKPREF1).$(PACKPREF2)
PACKAGE		= $(PACKPREF).$(PACKNAME)
PACKPATH	= $(PACKMAIN)/$(PACKPREF1)/$(PACKPREF2)/$(PACKNAME)
CLASSROOT	= $(HLT_HOME)/classes
SRCPATH		= $(HLT_HOME)/src/$(PACKMAIN)/$(PACKPREF1)/$(PACKPREF2)
PACKSRCDIR	= $(SRCPATH)/$(PACKNAME)
CLASSDIR	= $(CLASSROOT)/$(PACKPATH)
DOCDIR		= $(HLT_HOME)/doc/$(PACKMAIN)/code/$(PACKPREF1)/$(PACKPREF2)/$(PACKNAME)
#SAVEDIR		= $(HLT_HOME)/save/$(PACKPREF1)/$(PACKPREF2) # saving and backing is done and hlt/language level
JC		= @javac -classpath $(CLASSPATH) -O -d $(CLASSROOT)
SAY		= @echo "***"
TRASH		= $(PACKSRCDIR)/,* $(PACKSRCDIR)/,.* $(PACKSRCDIR)/*~ \
		  $(PACKSRCDIR)/@*@ $(PACKSRCDIR)/.*~ core 
NOW		= $(shell date +%Y_%m_%d-%I_%M_%S_%p)
########################################################################
all: kernel types instructions backend gen_all
	$(SAY) All $(PACKPREF) packages have been regenerated
########################################################################
full: all doc
########################################################################
doc: kernel_doc types_doc instructions_doc backend_doc
	$(SAY) Completed source documentation for all $(PACKPREF) packages
########################################################################
#save: kernel_save types_save instructions_save backend_save
########################################################################
backup: kernel_backup types_backup instructions_backup backend_backup
########################################################################
kernel: kernel_pack
types: types_pack
instructions: instructions_pack
backend: backend_pack
########################################################################
kernel_pack:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=kernel" gen_pack
types_pack:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=types" gen_pack
instructions_pack:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=instructions" gen_pack
backend_pack:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=backend" gen_pack
########################################################################
kernel_doc:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=kernel" gen_doc
types_doc:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=types" gen_doc
instructions_doc:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=instructions" gen_doc
backend_doc:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=backend" gen_doc
########################################################################
# kernel_save:
# 	@make -f "$(SRCPATH)/Makefile" "PACKNAME=kernel" gen_save
# types_save:
# 	@make -f "$(SRCPATH)/Makefile" "PACKNAME=types" gen_save
# instructions_save:
# 	@make -f "$(SRCPATH)/Makefile" "PACKNAME=instructions" gen_save
# backend_save:
# 	@make -f "$(SRCPATH)/Makefile" "PACKNAME=backend" gen_save
########################################################################
kernel_backup:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=kernel" gen_backup
types_backup:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=types" gen_backup
instructions_backup:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=instructions" gen_backup
backend_backup:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=backend" gen_backup
########################################################################
gen_pack: tidy
	$(SAY) Deleting $(PACKAGE) package classes
	@\rm -fr $(CLASSDIR)/*.class
########################################################################
gen_all:
	$(SAY) Compiling $(PACKPREF) package...
	$(JC) $(DIRFIX)*/*.java
	$(SAY) Regeneration of $(PACKPREF) package completed
########################################################################
gen_doc: tidy
	$(SAY) Generating hilited HTML source code for $(PACKAGE) package
	$(SAY) PACKAGE = $(PACKAGE)
	$(SAY) DOCDIR = $(DOCDIR)
	$(SAY) PACKSRCDIR = $(PACKSRCDIR)
#	@ls -al $(DOCDIR)/index.html
	@hl -! -s / -p $(PACKAGE) -d $(DOCDIR) $(PACKSRCDIR)/*.java > /dev/null
########################################################################
# gen_save: tidy
# 	@tar cvf $(PACKAGE).tar $(DIRFIX)$(PACKNAME)/*.java > /dev/null
# 	@gzip $(PACKAGE).tar
# 	$(SAY) Removing previously saved version of package $(PACKAGE)
# 	@rm -f $(SAVEDIR)/$(PACKNAME)/*$(PACKAGE).tar.gz
# 	$(SAY) Saving file $(PACKAGE).tar.gz in $(SAVEDIR)/$(PACKNAME)
# 	@mv -f $(PACKAGE).tar.gz $(SAVEDIR)/$(PACKNAME)/${NOW}-$(PACKAGE).tar.gz
# ########################################################################
# gen_backup: tidy
# 	@tar cvf $(PACKAGE).tar $(DIRFIX)$(PACKNAME)/*.java  > /dev/null
# 	@gzip $(PACKAGE).tar
# 	$(SAY) Backing up previously saved version in $(SAVEDIR)/$(PACKNAME)/BACKUPS
# 	@mv $(SAVEDIR)/$(PACKNAME)/*$(PACKAGE).tar.gz $(SAVEDIR)/$(PACKNAME)/BACKUPS
# 	$(SAY) Saving current package $(PACKAGE) in $(SAVEDIR)/$(PACKNAME)
# 	@mv ${NOW}-$(PACKAGE).tar.gz $(SAVEDIR)/$(PACKNAME)
########################################################################
kernel_tidy:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=kernel" tidy
types_tidy:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=types" tidy
instructions_tidy:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=instructions" tidy
backend_tidy:
	@make -f "$(SRCPATH)/Makefile" "PACKNAME=backend" tidy
########################################################################
tidy:
	$(SAY) Tidying up directory $(PACKSRCDIR)
	@\rm -rf $(TRASH)
########################################################################
clean: kernel_tidy types_tidy instructions_tidy backend_tidy
########################################################################
cvs: clean
	cvs add kernel/*.java types/*.java instructions/*.java backend/*.java || true
	$(SAY) Added all the files the CVS repository...
########################################################################
