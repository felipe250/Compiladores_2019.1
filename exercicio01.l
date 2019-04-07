/* 
Crie um Analisador Léxico utilizando Flex que consiga gerar os tokens
do arquivo de entrada "exercicio01.in" que consiste em um código na
linguagem C. O analisador deverá identificar todos os tokens referentes a:

1. Identificadores
2. Números Inteiros
3. Números de Ponto Flutuante
4. Palavras reservadas
5. Operadores Matemáticos e Relacionais
6. Chaves, Colchetes e Chaves

utilize os exemplos no diretório "flex" como ponto de partida.
*/

/*

- Para gerar o fonte digite
$ lex ex01.l

- Para compilar o fonte me C gerado digite
$ gcc ex01.yy.c

- Para executar
$ ./a.out

*/   


/* SEÇÃO DE DEFINIÇÕES */

%{
    /*
        Definições que estarão disponíveis 
            - variáveis
            - constantes
        O que for aqui será copiado para o arquivo *.yy.c
    
        Variáveis declaradas aqui estarão acessível nas funções yylex() e 
        main().
    */
    int contador = 0;
%}

/* Definições de Nomes */

WORD_DECISION  'if'|'else'|'switch'|'case'|'default'
WORD_TYPE      'int'|'float'|'char'|'double'|'long'
WORD_LOOP      'for'|'while'|'do'
WORD_DEFINES   'auto'|'signed'|'const'|'extern'|'register'|'unsigned'
WORD_STRUCTS   'struct'|'typedef'
WORD_OTHER     'volatile'|'union'|'sizeof'|'malloc'|'enum'|'continue'|'return'|'void'|'break'|'&'
ARITHMETIC_OPERATORS    "-"|"+"|"*"|"/"|"%"
RELATIONAL_OPERATORS    '=='|'!='|'>'|'<'|'>='|'<='
LOGICAL_OPERATORS       '&&'|"||"|'!'
BITWISE_OPERATORS       '&'|'|'|'^'|'~'|'>>'|'<<'
ASSIGNMENT_OPERATORS    "="|"+="|"-="|"*="|"/="|"%="|"<<="|">>="|"&="|"^="|"|="
CHAVE_COL   "["|"]"|"{"|"}"|"("|")"|"#"
NUMBER_INT                [0-9]+
NUMBER_FLOAT              [0-9]+"."[0-9]+
IDENTIFICADOR             [_a-zA-Z][_a-zA-Z0-9]*

/* FIM DA SEÇÃO DE DEFINIÇÕES */

%%
    /* SEÇAO DE REGRAS 
        Uma entrada por linha no formato:
        
        padrão  ação

    */

{NUMBER_FLOAT}         {printf("float ' %s ' \n", yytext); contador++;}
{NUMBER_INT}           {printf("int ' %s ' \n", yytext); contador++;}     
{CHAVE_COL}            {printf("chaves-colchetes ' %s ' \n", yytext); contador++;}
{WORD_DECISION}        {printf("decisao ' %s ' \n", yytext); contador++;}
{WORD_TYPE}            {printf("tipo ' %s ' \n", yytext); contador++;}
{WORD_LOOP}            {printf("loop ' %s ' \n", yytext); contador++;}
{WORD_DEFINES}         {printf("define ' %s ' \n", yytext); contador++;}
{WORD_STRUCTS}         {printf("struct ' %s ' \n", yytext); contador++;}
{WORD_OTHER}           {printf("outros ' %s ' \n", yytext); contador++;}
{ARITHMETIC_OPERATORS}       {printf("op-arith ' %s ' \n", yytext); contador++;}
{RELATIONAL_OPERATORS}       {printf("op-relac ' %s ' \n", yytext); contador++;}
{LOGICAL_OPERATORS}          {printf("op-logic ' %s ' \n", yytext); contador++;}
{BITWISE_OPERATORS}          {printf("op-bitabit ' %s ' \n", yytext); contador++;}
{ASSIGNMENT_OPERATORS}       {printf("op-atrib ' %s ' \n", yytext); contador++;}     
{IDENTIFICADOR}        {printf("identificador ' %s ' \n", yytext); contador++;}
<<EOF>>                return 0;
    
%%

/*
Seção de Código do Usuário
*/

int yywrap() {}
int main() {
    printf("Iniciando Análise Léxica...\n---\n");
    yylex();
    printf("Foram encontradas %d ocorrências de identificadores.\n", contador);
    printf("---\nÁnalise Finalizada!\n");
    
    return 0;
}