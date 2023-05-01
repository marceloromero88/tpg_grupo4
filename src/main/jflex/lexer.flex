package lyc.compiler;

import java_cup.runtime.Symbol;
import lyc.compiler.ParserSym;
import lyc.compiler.model.*;
import static lyc.compiler.constants.Constants.*;
import java.lang.Math;
import java.util.*;
import java.util.ArrayList;
import java.util.Vector;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;


%%

%public
%class Lexer
%unicode
%cup
%line
%column
%throws CompilerException
%eofval{
  return symbol(ParserSym.EOF);
%eofval}


%{

  public class Simbolo 
  
  {
      public String nombre;
      public String tipo;
      public String valor;
      public int longitud;

      public Simbolo(){}

      public Simbolo(String nombre, String tipo,String valor,int longitud) {
          this.nombre = nombre;
          this.tipo = tipo;
          this.valor = valor;
          this.longitud = longitud;
      }

          public String getNombre() {
              return nombre;
          }

          public String getTipo() {
              return tipo;
          }

          public String getValor() {
              return valor;
          }

          public int getLongitud() {
              return longitud;
          }

          public void mostrar_vector(){

          System.out.println("Nombre: " + nombre +"Tipo: " + tipo +"Valor: " + valor + "Longitud: " + longitud+ "\n");

          }
  }


  ArrayList<Simbolo> elemento = new ArrayList<Simbolo>();
  int ban=0;


  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }

  public void validar_rango_entero(String str)
    {
     int num = Integer.parseInt(str);
     if(num<=-32768 || num>=32767)
      {
          System.out.println("Entero fuera de rango\n");
      }
    }

  public void validar_long_string(String str)
    {
     int length = str.length();  
     if(length<=-3 || length>=40)
      {
          System.out.println("Cadena fuera de rango\n");
      }
    }

     public void guardar_TS(String tipo, String nombre){

         String lexema = "_"; //Armamos el lexema agregandole el guion bajo al principio
         String nom = lexema + nombre;
         Simbolo s;
         elemento.clear();
         //Simbolo s =buscar(nom); // buscamos si ya existe en la tabla
               // if(s == null){                //si no existe lo agregamos
                  s= new Simbolo(nom,tipo,nombre,0);
                  elemento.add(s);
                  //}
                 //elemento.get(cant).mostrar_vector();
                 //cant++;

          }

     public void guardar_TS_STR(String tipo, String nombre){

         String lexema = "_"; //Armamos el lexema agregandole el guion bajo al principio
         String nom = lexema + nombre;
         Simbolo s;
         elemento.clear();
         int length = nombre.length();
         //Simbolo s =buscar(nom); // buscamos si ya existe en la tabla
               // if(s == null){                //si no existe lo agregamos
                  s= new Simbolo(nom,tipo,nombre,length);
                  elemento.add(s);
                  //}
                // elemento.get(cant).mostrar_vector();
                 //cant++;

          }

    /* public Simbolo buscar(String nombre){
      Simbolo e=null;
     int i=0;
      while(i<vec.length){
        e=vec[i];
        if(vec[i] == null)
          break;
        if(vec[i].getNombre().equals(nombre)) break;
       e=null;
       i++;
       }
       return vec[i];
     }*/

      public void escribir_ts(){

                   try {
                                String ruta = "./tabla_de_simbolos.txt";
                                File file = new File(ruta);
                                int i=0;
                                // Si el archivo no existe es creado
                                if (!file.exists()) {
                                file.createNewFile();
                                                                        
                                }
                               
                                if (ban == 0)
                               {
                                FileWriter fa = new FileWriter(file,true);
                                BufferedWriter be = new BufferedWriter(fa);
                                be.write("Nombre "+ "\t  "+ "Tipo "+ "\t  "+ "Valor " + " \t   "+ "Longitud "+ "\n");
                                ban=1;
                              }

                                FileWriter fw = new FileWriter(file,true);
                                BufferedWriter bw = new BufferedWriter(fw);
                               // bw.write("Nombre "+ "\t  "+ "Tipo "+ "\t  "+ "valor " + " \t   "+ "Longitud "+ "\n");
                               // for(int i=0;i<elemento.size();i++)
                                //  {
                                     bw.write(elemento.get(i).getNombre() + "\t " +          elemento.get(i).getTipo() + "\t " +          elemento.get(i).getValor() + "\t " +        elemento.get(i).getLongitud() +"\n");
                                  //}

                                bw.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                    }

%}


LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
Identation =  [ \t\f]

Space = " "
Plus = "+"
Mult = "*"
Sub = "-"
Div = "/"
Assig = "="
Porc = "%"
COMA = ","
PUNTO_COMA = ";"
OPERACION_TIPO = ":"
ARROBA = "@"
CARACT = "½"
CARACT2 = "╗"
OpenBracket = "("
CloseBracket = ")"
QuotationMark = \"
AllowedSymbols = {Plus} | {Mult} | {Sub} | {Div} | {Assig} | {OpenBracket} | {CloseBracket} | {Porc} | {COMA} | {PUNTO_COMA} | {OPERACION_TIPO} | {ARROBA} | {CARACT} | {CARACT2}
Letter = [a-zA-Z]
Letter = [a-zA-Z]
Digit = [0-9]
CORCH_ABIERTO = "["
CORCH_CERRADO = "]"
LLAVE_ABIERTA = "{"
LLAVE_CERRADA = "}"
MENOR_IG = "<="
MENOR = "<"
MAYOR_IG = ">="
MAYOR = ">"
IGUAL = "=="
DISTINTO = "!="
WHILE = "WHILE"
ELSE = "ELSE"
DO = "DO"
CASE = "CASE"
DEFAULT = "DEFAULT"
ENDDO = "ENDDO"
IF = "IF"
WRITE = "WRITE"
READ = "READ"
OR = "OR"
AND = "AND"
NOT = "NOT"
OR = "OR"
init = "INIT"
float = "FLOAT"
int = "INT"
string = "STRING"
END = "END"
ESTACONTENIDO = "ESTACONTENIDO"


WhiteSpace = {LineTerminator} | {Identation}
Identifier = {Letter} ({Letter}|{Digit})*
IntegerConstant = {Digit}+
FloatConstant = {Digit}*\.({Digit}*|\.{Digit}+)
StringConstant = {QuotationMark} ({Letter}|{Digit}|{Space}|{AllowedSymbols})* {QuotationMark}
Comment = {Mult}{Sub} ({Letter}|{Digit}|{Space}|{AllowedSymbols})* {Sub}{Mult}

%%


/* keywords */

<YYINITIAL> {
  /* reserverd words */
  {IF}                                      { return symbol(ParserSym.IF); }
  {WHILE}                                   { return symbol(ParserSym.WHILE); }
  {READ}                                    { return symbol(ParserSym.READ); }
  {WRITE}                                   { return symbol(ParserSym.WRITE); }
  {AND}                                    { return symbol(ParserSym.AND); }
  {OR}                                   { return symbol(ParserSym.OR); }
  {NOT}                                   { return symbol(ParserSym.NOT); }
  {init}                                   { return symbol(ParserSym.INIT); }
  {int}                                   { return symbol(ParserSym.INT); }
  {string}                                   { return symbol(ParserSym.STRING); }
  {float}                                   { return symbol(ParserSym.FLOAT); }
  {DO}                                      { return symbol(ParserSym.DO); }
  {CASE}                                      { return symbol(ParserSym.CASE); }
  {DEFAULT}                                      { return symbol(ParserSym.DEFAULT); }
  {ENDDO}                                      { return symbol(ParserSym.ENDDO); }
  {ELSE}                                      { return symbol(ParserSym.ELSE); }
  {ESTACONTENIDO}                          { return symbol(ParserSym.ESTACONTENIDO); }
  

  /* identifiers */
  {Identifier}                              {guardar_TS("ID",yytext());escribir_ts();return symbol(ParserSym.IDENTIFIER, yytext());} 

  /* Constants */
  {IntegerConstant}                        { validar_rango_entero(yytext());guardar_TS("Cte_entera",yytext());escribir_ts();return symbol(ParserSym.INTEGER_CONSTANT,yytext()); }
  {FloatConstant}                          { guardar_TS("Cte_real",yytext());escribir_ts();return symbol(ParserSym.FLOAT_CONSTANT, yytext()); }
  {StringConstant}                         { validar_long_string(yytext());guardar_TS_STR("Cte_string",yytext());escribir_ts();return symbol(ParserSym.STRING_CONSTANT, yytext()); }


  /* operators */
  {Plus}                                    { return symbol(ParserSym.PLUS); }
  {Sub}                                     { return symbol(ParserSym.SUB); }
  {Mult}                                    { return symbol(ParserSym.MULT); }
  {Div}                                     { return symbol(ParserSym.DIV); }
  {Assig}                                   { return symbol(ParserSym.ASSIG); }
  {OpenBracket}                             { return symbol(ParserSym.OPEN_BRACKET); }
  {CloseBracket}                            { return symbol(ParserSym.CLOSE_BRACKET); }
  {COMA}                                    { return symbol(ParserSym.COMA); }
  {PUNTO_COMA}                              { return symbol(ParserSym.PUNTO_COMA); }
  {OPERACION_TIPO}                          { return symbol(ParserSym.OPERACION_TIPO); }
  {CORCH_ABIERTO}                           { return symbol(ParserSym.CORCH_ABIERTO); }
  {CORCH_CERRADO}                           { return symbol(ParserSym.CORCH_CERRADO); }
  {LLAVE_ABIERTA}                           { return symbol(ParserSym.LLAVE_ABIERTA); }
  {LLAVE_CERRADA}                           { return symbol(ParserSym.LLAVE_CERRADA); }
  {MENOR_IG}                                { return symbol(ParserSym.MENOR_IG); }
  {MAYOR_IG}                                { return symbol(ParserSym.MAYOR_IG); }
  {MAYOR}                                   { return symbol(ParserSym.MAYOR); }
  {IGUAL}                                   { return symbol(ParserSym.IGUAL); }
  {DISTINTO}                                { return symbol(ParserSym.DISTINTO); }
  {Comment}                                   { /* ignore */ }
   
  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }
  
}


/* error fallback */
[^]                              { throw new UnknownCharacterException(yytext()); }