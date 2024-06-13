
# Analizador léxico y sintáctico traductor utilizando flex y yacc/bison. 

Programa para la asignatura de Compiladores en el que el analizador debe aceptar un archivo de entrada con la cadena a ser analizada y mostrar la traducción correspondiente.







## Authors

- [@diegoesr](https://github.com/diegoesr)


## Deployment

Una vez instalado Flex y Bison los comandos para correr el programa son los siguientes:

Actividad 1.

```bash
    flex lex.l
    bison -d yacc.y
    gcc lex.yy.c yacc.tab.c -o traductor
    traductor test.txt
```

Actividad 2.

```bash
    flex lexer.l
    bison -d grammar.y
    gcc lex.yy.c grammar.tab.c -o parser
    parser test.txt
```

![Logo](https://i.ytimg.com/vi/yZ6Po_kEkD8/maxresdefault.jpg)

