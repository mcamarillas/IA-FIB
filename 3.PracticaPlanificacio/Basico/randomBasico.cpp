#include <stdlib.h>
#include <time.h>
#include <sstream>
#include <iostream>
#include <fstream>
using namespace std;

void header(int nh, int nr, ofstream &salida){
    salida << "(define (problem problemaBasico)" << endl
    << " (:domain dominioBasico)" << endl << endl
    << " (:objects" << endl << "   ";
    cout << nh << " " << nr << endl;
    for(int i = 1; i <= nh; ++i) {
      string str;
      stringstream ss;
      ss << i;
      ss >> str;
      string s1 = "hab"+str+" ";
      salida << s1;
    }
    salida << " -habitacion" << endl << "   ";
    for(int i = 1; i <= nr; ++i) {
      string str;
      stringstream ss2;
      ss2 << i;
      ss2 >> str;
      string s1 = "res"+str+" ";
      salida << s1;
    }

    salida <<	"- reserva" << endl
    <<	" )" << endl << endl
    << " (:init" << endl;
    for(int i = 1; i <= nr; ++i) {
      salida << "   (not (resuelta res" << i << "))" << endl;
    }
    for(int i = 1; i <= nh; ++i) {
      salida << "   (= (plazas hab" << i << ") 4)" << endl;
    }
}

void body(int n, ofstream &salida) {
    int inicio = 0, fin = 0, pers;
    srand(time(NULL));
    for(int i = 1; i <= n; ++i)
    {
       inicio = 1 + (fin-inicio)/2 + rand()%(29 -(fin-inicio)/2);
       fin = inicio + 1 + rand() % (30 - inicio);
       pers = 1 + rand() % (4);

       string str;
       stringstream ss;
       ss << i;
       ss >> str;
       string s1 = "   (= (personas res"+str;
       stringstream ss2;
       ss2 << pers;
       ss2 >> str;
       s1 += ") "+str+")";

       stringstream ss3;
       ss3 << i;
       ss3 >> str;
       string s2 = "   (= (inicio res"+str;
       stringstream ss4;
       ss4 << inicio;
       ss4 >> str;
       s2 += ") "+str+")";

       stringstream ss5;
       ss5 << i;
       ss5 >> str;
       string s3 = "   (= (fin res"+str;
       stringstream ss6;
       ss6 << fin;
       ss6 >> str;
       s3 += ") "+str+")";

       salida << s1 << endl;
       salida << s2 << endl;
       salida << s3 << endl;
    }
}

void ending(ofstream &salida) {
    salida << " )" << endl
    << " (:goal" << endl
    << "   (forall (?res - reserva) (resuelta?res))" << endl
    << " )" << endl
    << ")" << endl;
}

int main(int argc, char **argv) {
   ofstream salida;
   salida.open("problemaBasico.pddl");
   int nr = atoi(argv[2]);
   int nh = atoi(argv[1]);
   header(nh, nr, salida);
   body(nr, salida);
   ending(salida);
   return 0;
}
