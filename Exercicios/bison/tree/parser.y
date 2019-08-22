%{
/* Código C, use para #include, variáveis globais e constantes
 * este código ser adicionado no início do arquivo fonte em C
 * que será gerado.
 */
#include <stdio.h>
#include <stdlib.h>
typedef struct No {
    char token[50];
    int num_filhos;
    struct No** filhos;
} No;
No* allocar_no();
void liberar_no(No* no);
void imprimir_arvore(No* raiz);
No* novo_no(char[50], No**, int);
%}
/* Declaração de Tokens no formato %token NOME_DO_TOKEN */
%union 
{
    int number;
    char simbolo[50];
    struct No* no;
}
%token NUM
%token ADD
%token SUB
%token MUL
%token DIV
%token APAR
%token FPAR
%token EOL
%type<no> calc
%type<no> termo
%type<no> fator
%type<no> exp
%type<simbolo> NUM
%type<simbolo> MUL
%type<simbolo> DIV
%type<simbolo> SUB
%type<simbolo> ADD
%%
/* Regras de Sintaxe */
//Imprime a arvore completa (exp) e libera espaços alocados
calc:
    | calc exp EOL      { imprimir_arvore($1); liberar_no($1);} 
//Termo ou 
exp: termo 
   //expressão somando com um termo              
   | exp ADD termo      {
                            No** filhos = (No**) malloc(sizeof(No*)*3);
                            filhos[0] = $1;
                            filhos[1] = novo_no("+", NULL, 0);
                            filhos[2] = $3;
                            $$ = novo_no("exp", filhos, 3);
                        }
   // expressao subtraindo termo
   | exp SUB termo      {
                        No** filhos = (No**) malloc(sizeof(No*)*3);
                        filhos[0] = $1;
                        filhos[1] = novo_no("-", NULL, 0);
                        filhos[2] = $3;
                        $$ = novo_no("exp", filhos, 3);
    }
   ;
//fator ou
termo: fator
     //termo multiplicando fator
     | termo MUL fator  {                             
                            No** filhos = (No**) malloc(sizeof(No*)*3);
                            filhos[0] = $1;
                            filhos[1] = novo_no("*", NULL, 0);
                            filhos[2] = $3;
                            $$ = novo_no("termo", filhos, 3);}
     //termo dividindo fator
     | termo DIV fator  {                             
                            No** filhos = (No**) malloc(sizeof(No*)*3);
                            filhos[0] = $1;
                            filhos[1] = novo_no("/", NULL, 0);
                            filhos[2] = $3;
                            $$ = novo_no("termo", filhos, 3);
                            }
     ;
fator: NUM {No** filhos = (No**) malloc(sizeof(No*));
            filhos[0] = novo_no($1,NULL,0); 
            $$ = novo_no("fator", filhos, 1); }               
%%
/* Código C geral, será adicionado ao final do código fonte 
 * C gerado.
 */
No* allocar_no(int num_filhos) {
    return (No*) malloc(sizeof(No)* num_filhos);
}
void liberar_no(No* no) {
    free(no);
}
No* novo_no(char token[50], No** filhos, int num_filhos) {
    No* no = allocar_no(num_filhos);
    snprintf(no->token, 50, "%s", token);
    no->num_filhos= num_filhos;
    no->filhos = filhos;
    return no;
}
void imprimir_arvore(No* raiz) {
    printf("(%s)", raiz->token);
    int i;
    printf(" -> ");
    for (i = 0; i < raiz->num_filhos; i++){  
        imprimir_arvore(raiz->filhos[i]);
        if(raiz->filhos[i]->filhos == NULL) printf("(null)\n");
    }
}
int main(int argc, char** argv) {
    yyparse();
}
yyerror(char *s) {
    fprintf(stderr, "error: %s\n", s);
}
