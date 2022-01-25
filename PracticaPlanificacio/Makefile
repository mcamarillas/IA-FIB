all: generadorBasico generadorExt1 generadorExt2 generadorExt3 generadorExt4

generadorBasico:
	g++ -o ./Basico/randomBasico ./Basico/randomBasico.cpp

generadorExt1:
	g++ -o ./Extension1/randomExtension1 ./Extension1/randomExtension1.cpp

generadorExt2:
	g++ -o ./Extension2/randomExtension2 ./Extension2/randomExtension2.cpp

generadorExt3:
	g++ -o ./Extension3/randomExtension3 ./Extension3/randomExtension3.cpp

generadorExt4:
	g++ -o ./Extension4/randomExtension4 ./Extension4/randomExtension4.cpp


basico: 
	./ff -o ./Basico/dominioBasico.pddl -f ./Basico/problemaBasico.pddl

ext1: 
	./ff -O -o ./Extension1/dominioExtension1.pddl -f ./Extension1/problemaExtension1.pddl

ext2: 
	./ff -O -o ./Extension2/dominioExtension2.pddl -f ./Extension2/problemaExtension2.pddl

ext3: 
	./ff -O -o ./Extension3/dominioExtension3.pddl -f ./Extension3/problemaExtension3.pddl

ext4: 
	./ff -O -o ./Extension4/dominioExtension4.pddl -f ./Extension4/problemaExtension4.pddl