%{
#include <stdio.h> // Biblioteca para funciones de entrada y salida.
#include <stdlib.h> // Biblioteca para funciones de utilidades generales. 
#include <string.h> // Biblioteca para manipulación de cadenas.

void yyerror(const char *s); // Función yyerror que se utiliza para manejar errores sintácticos.
int yylex(void); // Función yylex que se utiliza para invocar el analizador léxico.
extern FILE *yyin; // Variable externa yyin que se utiliza para establecer el archivo de entrada del analizador léxico.
%}

%union {
    char* str;
}

%token <str> BIG REAL SYMBOL IDENTIFICADOR CADENA NUMERO

%type <str> tipo lista_vars var valor

%%

/*Define una declaración que consiste en un tipo, una lista de variables y un punto y coma.*/
declaracion:
    tipo lista_vars ';' { printf("Las variables son de tipo %s\n", $1); } // Nos especifica que una declaración válida tiene esta estructura, imprime el tipo de las variables, '$1' se refiere al primer elemento de la regla de produccion.
;

/*Define los posibles tipos de variables: BIG, REAL, y SYMBOL.*/
tipo: // Cada acción semántica se le asigna una cadena que representa el tipo al valor de la regla ($$).
    BIG { $$ = strdup("big"); }
  | REAL { $$ = strdup("real"); }
  | SYMBOL { $$ = strdup("symbol"); }
;

/*Define una lista de variables que puede ser una sola variable o una lista de variables separadas por comas.*/
lista_vars:
    var { } // Es una acción vacía por lo tanto no se realiza ninguna operación adicional.
  | lista_vars ',' var { }
;

/*Define una variable que puede ser un identificador solo o un identificador con un valor asignado.*/
var:
    IDENTIFICADOR { } // Es una acción vacía por lo tanto no se realiza ninguna operación adicional.
  | IDENTIFICADOR '=' valor { }
;

/*Define un valor que puede ser una cadena o un número.*/
valor:
    CADENA { } // Es una acción vacía por lo tanto no se realiza ninguna operación adicional.
  | NUMERO { }
;

%%

/*Función yyerror que se llama cuando se encuentra un error sintáctico.*/
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char *argv[]) { // Punto de entrada del programa.
    if (argc != 2) { // Verifica que este correctamente nombre del archivo de entrada (test.txt).
        fprintf(stderr, "El archivo de entrada debe ser: %s <archivo_entrada>\n", argv[0]);
        return 1;
    }

    FILE *archivo_entrada = fopen(argv[1], "r"); // Abre el archivo de entrada (.txt).
    /*Si el archivo no se abre correctamente imprime un mensaje de error.*/
    if (!archivo_entrada) { 
        perror("No se puede abrir el archivo de entrada");
        return 1;
    }

    yyin = archivo_entrada; // Asigna el archivo de entrada a la variable yyin que el analizador léxico usará.
    yyparse(); // Llama al analizador sintáctico para que procese archivo de entrada.
    fclose(archivo_entrada); // Cierra el archivo de entrada.
    return 0; // Termina el programa.
}
