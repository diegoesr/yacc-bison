%{
// Bibliotecas para entrada/salida y funciones estándar.
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s); // Declara la función yyerror para manejar los errores.
int yylex(void); // Declara la función yylex que será definida por flex para realizar el análisis léxico.
extern FILE *yyin; // Será utilizada para establecer el archivo de entrada (test.txt).

// Declara e inicializa variables para contar las ocurrencias de a, b, y c.
int num_a = 0;
int num_b = 0;
int num_c = 0;
%}

%token a b c 

%%

input:
    | input linea // Puede estar vacia o puede consistir en una o mas.
    ;

linea: // La regla linea puede ser una producción que consista en S seguido de un salto de línea.
    S '\n' { printf("Linea valida\n"); }
  | '\n'
  ;

S : 'a' S { num_a++; } // Puede ser un a seguido de S, o un 'b' seguido de 'A' y 'c'.
  | 'b' A 'c' { num_b++; num_c++; }
  ;

A : 'b' A 'c' { num_b++; num_c++; } // Puede ser un b seguido de 'A' y 'c' , o simplemente un 'b'.
  | 'b' { num_b++; }
  ;

%%

void yyerror(const char *s) { // Maneja los errores de análisis, imprimiendo un mensaje de error.
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char **argv) {
    if (argc > 1) { // Verifica si se ha proporcionado un archivo de entrada como argumento.
        yyin = fopen(argv[1], "r"); //Abre el archivo de entrada.
        if (!yyin) { // Si el archivo no se puede abrir, imprime un mensaje de error y termina el programa.
            perror(argv[1]);
            return 1;
        }
    } else { // Si no se proporciona un archivo de entrada, imprime un mensaje de uso y termina el programa.
        fprintf(stderr, "El archivo de entrada debe ser: %s <input_file>\n", argv[0]);
        return 1;
    }

    printf("Analisis comenzando...\n"); // Imprime un mensaje indicando que el análisis está comenzando.
    int result = yyparse(); // Realiza el analisis sintactico
    printf("Analisis finalizado: %d\n", result); // Imprime el resultado del análisis.
    printf("num_a: %d, num_b: %d, num_c: %d\n", num_a, num_b, num_c); // Imprime el número de a, b, y c encontrados.
    
    for (int i = 0; i < 2 * num_b; i++) { // Imprime ('2 * num_b') caracteres 'b'. El valor de num_b es el número de veces que el token b fue encontrado en las producciones de la gramática. 
        printf("b");
    }
    for (int i = 0; i < num_a; i++) { // Imprime 'num_a' caracteres 'a'. El valor de num_a es el número de veces que el token a fue encontrado en las producciones de la gramática.
        printf("a");
    }
    printf("\n"); // Imprime un salto de linea.
    fclose(yyin); // Cierra el archivo de entrada.
    return 0; // Termina el programa.
}
