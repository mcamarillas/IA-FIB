#include <stdlib.h>
#include <time.h>
#include <sstream>
#include <iostream>
#include <fstream>
using namespace std;

void header(int nh, int nr, ofstream &salida){
    salida << "(define (problem problemaExtension2)" << endl
    << " (:domain dominioExtension2)" << endl << endl
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
    salida << "   (= (total-cost) 0)" << endl;
    salida << "   (= (num-res) " << nr << ")" << endl;
    srand(time(NULL));
    for(int i = 1; i <= nh; ++i) {
      int np = 1 + rand() % (4);
      salida << "   (= (plazas hab" << i << ") " << np << ")" << endl;
      np = 1 + rand() % (4);
      salida << "   (= (pcardinalhab hab" << i << ") " << np << ")" << endl;
    }
}

void body(int n, ofstream &salida) {
    int inicio = 0, fin = 0, r, pers;
    srand(time(NULL));
    for(int i = 1; i <= n; ++i)
    {
       inicio = 1 + (fin-inicio)/2 + rand()%(29 -(fin-inicio)/2);
       fin = inicio + 1 + rand() % (30 - inicio);
       pers = 1 + rand() % (4);
       r = 1 + rand() % (4);

       salida << "   (= (personas res" << i << ") " << pers << ")" << endl;
       salida << "   (= (inicio res" << i << ") " << inicio << ")" << endl;
       salida << "   (= (fin res" << i << ") " << fin << ")" << endl;
       salida << "   (= (pcardinalres res" << i << ") " << r << ")" << endl;
    }
}

void ending(ofstream &salida) {
    salida << " )" << endl
    << " (:goal" << endl
    << "   (forall (?res - reserva) (resuelta ?res))" << endl
    << " )" << endl
    << "(:metric minimize (total-cost))" << endl
    << ")" << endl;
}

int main(int argc, char **argv) {
   ofstream salida;
   salida.open("problemaExtension2.pddl");
   int nr = atoi(argv[2]);
   int nh = atoi(argv[1]);
   header(nh, nr, salida);
   body(nr, salida);
   ending(salida);
   return 0;
}
