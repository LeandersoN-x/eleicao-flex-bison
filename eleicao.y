%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);

void yyerror(const char *s)
{
    printf("ERRO\n");
}
%}

%union {
    struct {
        int valor;
        int tamanho;
    } num;
    int valor;
}

%token <num> NUM
%token LOCAL
%token FORA
%token PRIMEIRO
%token SEGUNDO
%token BRANCO
%token ERRO
%type <valor> senador1 senador2

%%

entrada:
      LOCAL PRIMEIRO primeiro_turno '\n'
      { printf("PIRILILILIM\n"); YYACCEPT; }
    | LOCAL SEGUNDO segundo_turno '\n'
      { printf("PIRILILILIM\n"); YYACCEPT; }
    | FORA PRIMEIRO presidente '\n'
      { printf("PIRILILILIM\n"); YYACCEPT; }
    | FORA SEGUNDO presidente '\n'
      { printf("PIRILILILIM\n"); YYACCEPT; }
    | error '\n'
      { yyerrok; YYABORT; }
    ;

primeiro_turno:
      federal estadual senador1 senador2 governador presidente
      {
          if ($3 != -1 && $3 == $4) {
              yyerror("");
              YYABORT;
          }
      }
    ;

segundo_turno:
      governador presidente
    ;

federal:
      NUM
      {
          int partido;
          if ($1.tamanho == 4)       partido = $1.valor / 100;
          else if ($1.tamanho == 2)  partido = $1.valor;
          else { yyerror(""); YYABORT; }
          if (partido < 10 || partido > 99) { yyerror(""); YYABORT; }
      }
    | BRANCO
    ;

estadual:
      NUM
      {
          int partido;
          if ($1.tamanho == 5)       partido = $1.valor / 1000;
          else if ($1.tamanho == 2)  partido = $1.valor;
          else { yyerror(""); YYABORT; }
          if (partido < 10 || partido > 99) { yyerror(""); YYABORT; }
      }
    | BRANCO
    ;

senador1:
      NUM
      {
          if ($1.tamanho != 3 || $1.valor == 0) { yyerror(""); YYABORT; }
          $$ = $1.valor;
      }
    | BRANCO
      { $$ = -1; }
    ;

senador2:
      NUM
      {
          if ($1.tamanho != 3 || $1.valor == 0) { yyerror(""); YYABORT; }
          $$ = $1.valor;
      }
    | BRANCO
      { $$ = -1; }
    ;

governador:
      NUM
      {
          if ($1.tamanho != 2 || $1.valor < 10 || $1.valor > 99) {
              yyerror("");
              YYABORT;
          }
      }
    | BRANCO
    ;

presidente:
      NUM
      {
          if ($1.tamanho != 2 || $1.valor < 10 || $1.valor > 99) {
              yyerror("");
              YYABORT;
          }
      }
    | BRANCO
    ;

%%

int main(void)
{
    yyparse();
    return 0;
}
