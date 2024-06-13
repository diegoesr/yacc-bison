%{
    
/*
    Tercer Examen Parcial
    Actividad 1
    Compiladores G03
    Semestre 2024-2    
    Integrantes:
        Castañeda Aranada Alma Adriana
        Esparza Rodríguez Diego
        Zuckerman Cisneros Stephan
    Profesora:
        Elba Karen Sáenz García
*/

#include "yacc.tab.h" // Definiciones de tokens y declaraciones necesarias para la integración entre flex y bison.
%}

/*Reglas de escaneo*/

%%

a   { return 'a'; } // Especifica que cuando se encuentre el carácter 'a' en el texto de entrada, el escáner debe devolver el token 'a'.
b   { return 'b'; } // Especifica que cuando se encuentre el carácter 'b' en el texto de entrada, el escáner debe devolver el token 'b'.
c   { return 'c'; } // Especifica que cuando se encuentre el carácter 'c' en el texto de entrada, el escáner debe devolver el token 'c'.
\n  { return '\n'; } //  especifica que cuando se encuentre un salto de línea en el texto de entrada, el escáner debe devolver el token '\n'.
.   { /* ignora cualquier otro carácter */ }

%%

/* Función es llamada por el escáner generado por flex cuando llega al final de la entrada.*/
int yywrap() {
    return 1; // Indica el fin de la entrada al analizador sintáctico. 
}
