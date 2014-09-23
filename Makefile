#-----------------------------------------------------------------------------
# Makefile for lex/yacc
# Lei Liu (liulei@shao.ac.cn)
# Sep. 9, 2014
#-----------------------------------------------------------------------------

CC      =   gcc
CPP     =   g++

INCL    =   
LIBS    =   -ll

CFLAGS      =   -g -W -Wall $(INCL) #-O3
CPPFLAGS    =   -g -W -Wall $(INCL) #-O3

EXEC    =   readjob

LEX     =   job.l
YACC    =   job.y

$(EXEC) : $(LEX) $(YACC) Makefile
	flex    job.l
	bison -dy job.y
	$(CC) *.c $(CFLAGS) $(INCL) $(LIBS) -o $(EXEC)

clean:
	rm -f *.o *.c *.h
	rm -f $(EXEC)



