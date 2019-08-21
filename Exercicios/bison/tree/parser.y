Skip to content
 
Search or jump to…

Pull requests
Issues
Marketplace
Explore
 
@felipe250 
0
0 0 MarcosFortuna/CET-058-2019.1-
 Code  Issues 0  Pull requests 0  Projects 0  Wiki  Security  Insights
CET-058-2019.1-/Exercicios/bison/tree/parser.y
@MarcosFortuna MarcosFortuna inserção dos codigo do bison
c04860b 5 days ago
146 lines (122 sloc)  3.43 KB
    
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
calc:
    | calc exp EOL       { imprimir_arvore($2); } 
exp: fator               
   | exp ADD fator      {
                            No** filhos = (No**) malloc(sizeof(No*)*3);
                            filhos[0] = $1;
                            filhos[1] = novo_no("+", NULL, 0);
                            filhos[2] = $3;
                            $$ = novo_no("exp", filhos, 3);
                        }
   | exp SUB fator      {
                        No** filhos = (No**) malloc(sizeof(No*)*3);
                        filhos[0] = $1;
                        filhos[1] = novo_no("-", NULL, 0);
                        filhos[2] = $3;
                        $$ = novo_no("exp", filhos, 3);
    }
   ;
fator: termo            
     | fator MUL termo  {                             
                            No** filhos = (No**) malloc(sizeof(No*)*3);
                            filhos[0] = $1;
                            filhos[1] = novo_no("*", NULL, 0);
                            filhos[2] = $3;
                            $$ = novo_no("termo", filhos, 3);}
     | fator DIV termo  {                             
                            No** filhos = (No**) malloc(sizeof(No*)*3);
                            filhos[0] = $1;
                            filhos[1] = novo_no("/", NULL, 0);
                            filhos[2] = $3;
                            $$ = novo_no("termo", filhos, 3);
                            }
     ;
termo: NUM {No** filhos = (No**) malloc(sizeof(No*));
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
    //if(raiz == NULL) { printf("#"); return; }
    printf("(%s)", raiz->token);
    int i = 0;
    printf(" -> ");
    while (i < raiz->num_filhos)
    {  
        imprimir_arvore(raiz->filhos[i]);
        if(raiz->filhos[i]->filhos == NULL) printf("#\n");
        i++;
    }
   /* if(raiz == NULL) { printf("***"); return; }
    printf("(%s)", raiz->token);
    int i = 0;
    while(raiz->filhos[i] != NULL){
        printf("->");
        imprimir_arvore(raiz->filhos[i]);
        
    }
    */
}
int main(int argc, char** argv) {
    yyparse();
}
yyerror(char *s) {
    fprintf(stderr, "error: %s\n", s);
}
© 2019 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
Pricing
API
Training
Blog
About
