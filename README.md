

Simples implementação de um sistema de processamento para dados de eleição utilizando Flex e Bison. Ele realiza a análise léxica e sintática dos dados de votação para processar e contabilizar os resultados.

# Execução: 
flex eleicao.l <br>
bison -d eleicao.y <br>
gcc -o eleicao eleicao.tab.c lex.yy.c -lfl
