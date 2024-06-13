%{

/*
    Tercer Examen Parcial
    Actividad 2
    Compiladores G03
    Semestre 2024-2    
    Integrantes:
        Castañeda Aranada Alma Adriana
        Esparza Rodríguez Diego
        Zuckerman Cisneros Stephan
    Profesora:
        Elba Karen Sáenz García
*/


#include "grammar.tab.h" // Archivo generado por Bison que contiene las definiciones de los tokens y otras declaraciones necesarias.

/* Bibliotecas de C para funciones de memoria y manipulación de cadenas.*/
#include <stdlib.h> 
#include <string.h>  

void yyerror(const char *s); // Funcion que se utilizara para manejar los errores.
%}

%%

"big"         { yylval.str = strdup("big"); return BIG; } // Reconoce la palabra 'big' , despues asigna la cadena 'big' al valor lexico 'yylval' y devuelve el token 'BIG'.
"real"        { yylval.str = strdup("real"); return REAL; } // Reconoce la palabra 'real', despues asigna la cadena 'real' al valor lexico 'yyval' y devuelve el token 'REAL'.
"symbol"      { yylval.str = strdup("symbol"); return SYMBOL; } // Reconoce la palabra 'symbol', despues asigna la cadena 'symbol' al valor lexico 'yyval' y devuelve el token 'SYMBOL'.
\"[^\"]*\"    { yylval.str = strdup(yytext); return CADENA; } // Reconoce las cadenas de caracteres entre comillas dobles, asigna la cadena reconocida a 'yyval' y devuelve el token 'CADENA'.
\$[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return IDENTIFICADOR; } // Reconoce identif que comienzan con '$' seguido de letras o numeros, asigna el identif a 'yyval' y devuleve el token 'IDENTIFICADOR'.
[0-9]+        { yylval.str = strdup(yytext); return NUMERO; } // Reconoce secuencias de uno o mas digitoas, despues asigna la cadena de digitos a 'yyval' y devuelve el token 'NUMERO'.
[ \t\n\r]+    { /* Ignora espacios en blanco y saltos de línea */ }
[,;=]         { return yytext[0]; }  // Devuelve los caracteres , ; = 
.             { yyerror("Carácter no válido"); } // Reconoce cualquier otro caracter que no hayamos definido en las reglas anteriores y manda el mensaje.

%%

/*Se llama la funcion cuando se alcanza el final de la entrada y devuelve 1 indicaando que no hay más datos por procesar.*/
int yywrap(void) {
    return 1;
}
