// import sekcija

import java_cup.runtime.*;

%%

// sekcija opcija i deklaracija
%class MPLexer

%cup


%eofval{
    return new Symbol( sym.EOF );
%eofval}


// stanja
%xstate COMMENT

// makroi
slovo = [a-zA-Z_]
cifra = [0-9]
hex_cifra = [0-9a-fA-F]

// regularni izrazi za različite tipove konstanti
octal = 0#o{cifra}+
hex = 0#x{hex_cifra}+
dec = 0#d{cifra}+
int_const = {dec}|{octal}|{hex}|{cifra}+
float_const = "0."{cifra}*([eE][+-]?{cifra}+)?
char_const = \'[^']\'
bool_const = true|false

%%

// pravila za komentare
"%"                            { yybegin(COMMENT); }
<COMMENT>~"%"                  { yybegin(YYINITIAL); }

// ignorisanje belina
[\t\n\r ]                      { ; }

// specijalni simboli
"{"                            { return new Symbol( sym.LBRACE ) }
"}"                            { return new Symbol( sym.RBRACE ) }
"("                            { return new Symbol( sym.LEFTPAR ) }
")"                            { return new Symbol( sym.RIGHTPAR ) }
";"                            { return new Symbol( sym.SEMICOLON ) }
","                            { return new Symbol( sym.COMMA ) }

// operator dodele
"="                            { return new Symbol( sym.ASSIGN ) }

// logički operatori
"||"                           { return new Symbol( sym.OR ) }
"&&"                           { return new Symbol( sym.AND ) }

// relacijski operatori
"<="                           { return new Symbol( sym.LE ) }
"<"                            { return new Symbol( sym.LT ) }
">="                           { return new Symbol( sym.GE ) }
">"                            { return new Symbol( sym.GT ) }
"=="                           { return new Symbol( sym.EQ ) }
"!="                           { return new Symbol( sym.NE ) }

// ključne reči
"main"                         { return new Symbol( sym.MAIN ) }
"int"                          { return new Symbol( sym.INT ) }
"char"                         { return new Symbol( sym.CHAR ) }
"float"                        { return new Symbol( sym.FLOAT ) }
"bool"                         { return new Symbol( sym.BOOL ) }
"loop"                         { return new Symbol( sym.LOOP ) }
"redo"                         { return new Symbol( sym.REDO ) }

// identifikatori
{slovo}({slovo}|{cifra})*      { return new Symbol(sym.ID ) }

// konstante
{int_const}                    { return new Symbol(sym.INT_CONST ) }
{float_const}                  { return new Symbol(sym.FLOAT_CONST ) }
{char_const}                   { return new Symbol(sym.CHAR_CONST ) }
{bool_const}                   { return new Symbol(sym.BOOL_CONST ) }

// obrada grešaka
.                              { System.err.println("ERROR: " + yytext()); }
