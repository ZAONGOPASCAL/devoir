/*ZAONGO PASCAL ABDOUL RAZAK && KONE BADRA ALI*/

%{
#include <stdio.h>
%}
%option yylineno

lettre [A-Za-z]
chiffre [0-9]
sep [_]
IDENT {lettre}({lettre}|{chiffre}|{sep})*
OP_ARITHM "+"|"-"|"*"
OP_LOG "&&"|"||"|"!"|"=="
affect "="
point "\."
reel {chiffre}+|{point}{chiffre}+([eE][+-]?[0-9]+)?
motcle "if"|"while"|"else"
commentaire ["//"].*
OP_REL "<"|">"|"<="|">="|"!="

%%
{chiffre}+        { printf("ENTIER : %s\n", yytext); }
\"([^\"]+)\"	  { printf("CHAINE : %.*s\n",yyleng - 2, yytext + 1); }
"int"		  { printf("TYPE : %s\n", yytext); }
{motcle}	  { printf("MCLEF : %s\n", yytext); }
{reel}+		  { printf("REEL : %f\n", atof(yytext)); }
{OP_ARITHM}	  { printf("OP_ARITHM : %s\n", yytext); }
{OP_LOG}	  { printf("OP_LOG : %s\n", yytext); }
{OP_REL}	  { printf("OP_REL : %s\n", yytext); }

 [0-9]*\.[0-9]+[eE][+-]?[^0-9]+  //{ fprintf(stderr, "** Erreur ligne %d ** : exposant attendu [%s]\n", yylineno, yytext); }

{affect}	  { printf("AFFECT : %s\n", yytext); }
{IDENT}+	  { printf("IDENT : %s\n", yytext); }
\"[^\"]*$         { printf("** erreur ligne %d ** : fin de chaine attendu [%s]\n", yylineno, yytext); }
"//".*		  { printf("COMMENTAIRE \n"); }
[,\;\(\)\{\}\[\]] { printf("SEP : %s\n", yytext); }
[ \t\n]     ;  // Ignorer les espaces, tabulations et nouvelles lignes
.		  { printf("** erreur ligne %d ** : caractere inconnu [%s]\n",yylineno, yytext); }
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}

int yywrap(){
    return 1;
}
