%option noyywrap

%{
#include "eleicao.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+    {
              yylval.num.valor = atoi(yytext);
              yylval.num.tamanho = yyleng;
              return NUM;
          }

LOCAL     { return LOCAL; }
FORA      { return FORA; }
PRIMEIRO  { return PRIMEIRO; }
SEGUNDO   { return SEGUNDO; }
BRANCO    { return BRANCO; }

[ \t]+    { }

\n        { return '\n'; }

.         { return ERRO; }

%%
