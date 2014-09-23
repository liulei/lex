%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//#define YYSTYPE (char *)
extern FILE *yyin, *yyout;

void yyerror(char *str){
    fprintf(stderr, "error: %s\n", str);
}

int yywrap(){
    return 1;
}

%}

%start terms

%token VERSION SATELLITE MASTER STATION
%token WORD NUMBER MARK

%%

terms   :   /* empty */
        |   terms term
        ;

term    :   version
        |   satellite
        |   master
        |   station
        |   mark
        |   other
        ;

version :   VERSION '=' NUMBER ';'
            {   float ver = atof((char *)$3); 
                printf("Version number %.1f\n", ver);
            }
        ;

satellite   :   SATELLITE
                { printf("Found sat section.\n");}
            ;

station     :   STATION station_arrs
            ;

station_arrs    :   station_arr
                |   station_arr station_arrs
                ;

station_arr :   WORD NUMBER NUMBER NUMBER
                { 
                    printf("%s: %s|%s|%s\n", $1, $2, $3, $4);
                }
            ;

master      :   MASTER master_arr 
            ;

master_arr  :   WORD    NUMBER  NUMBER  NUMBER  NUMBER
                { printf("Exp code: %s\n", $1);
                  printf("start/end: %s/%s\n", $2, $3);
                }
            ;

mark    :   MARK
            { printf("!!! Mark.\n");}

other   :   WORD {printf("Unrecognized word %s.\n", $1); return 0;}
        |   NUMBER {printf("unrecognized number %s\n", $1); return 0;}
        |   ';' {}
        |   '=' {}
        ;

%%


int main(int argc, char **argv){
    if(argc < 2){
        return 0;
    }
    
    yyin = fopen(argv[1], "r");
    yyparse();
    fclose(yyin);
    return 0;
}

