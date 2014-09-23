%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}

pm      [\+\-]
number  {pm}?[0-9\.]+
word    [a-zA-Z0-9\._{pm}\/]+

%%

MARK        {return MARK;}
SATELLITE   {return SATELLITE;}
MASTER      {return MASTER;}
STATION     {return STATION;}
Table_rev   {return VERSION;}
{number}    {   yylval = (int)strdup(yytext); 
                return NUMBER;
            }
{word}      {   yylval = (int)strdup(yytext); 
                return WORD;
            }
=           {return (int) yytext[0];}
;           {return (int) yytext[0];}
\*.*\n      {/* ignore comment */}
.           {}
[ \t]+\n    {}
\n          {}

%%
