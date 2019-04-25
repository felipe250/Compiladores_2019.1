Das especificações da linguagem escolhida para o projeto de compiladores.

A linguagem C foi a selecioanda, apesar de não conter na totalidade 
as especificações da linguagem original.

Segue o que foi selecionado para a parte inicial da monetagem do compilador, o analisador.

1. Identificador alfanumérico: a - z, A - Z, 0 - 9
     expresso em: indentificador [_a-zA-Z][_a-zA-Z0-9]*


2. Números Inteiros 0 - 9
    expresso em: number_int [0-9]+ 


3. Números de Ponto Flutuante 0 - 9 '.' 0 - 9
    expresso em: number_float [0-9]+"."[0-9]+


4. Palavras reservadas
    expresso em:    word_decision  'if'|'else'|'switch'|'case'|'default'
                    word_type      'int'|'float'|'char'|'double'|'long'
                    word_loop      'for'|'while'|'do'
                    word_defines   'auto'|'signed'|'const'|'extern'|'register'|'unsigned'
                    word_structs   'struct'|'typedef'
                    word_other     'volatile'|'union'|'sizeof'|'malloc'|'enum'|'continue'|'return'|'void'|'break'|'&'


5. Operadores Matemáticos e Relacionais e outros
    expresso em:    arithmetic_operators :   "-"|"+"|"*"|"/"|"%"
                    relational_operators :   '=='|'!='|'>'|'<'|'>='|'<='
                    logical_operators    :   '&&'|"||"|'!'
                    bitwise_operators    :   '&'|'|'|'^'|'~'|'>>'|'<<'
                    assignment_operators :   "="|"+="|"-="|"*="|"/="|"%="|"<<="|">>="|"&="|"^="|"|="

6. Colchetes e Chaves
    expresso em: chave_col "["|"]"|"{"|"}"|"("|")"|"#"
