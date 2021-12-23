import aima.search.framework.Successor;
import aima.search.framework.SuccessorFunction;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class GasoSuccesorFunction2 implements SuccessorFunction {
    public List<Successor> getSuccessors(Object aState){
        ArrayList<Successor> sucesores = new ArrayList<>();
        GasoEstado estado = (GasoEstado) aState;
        Random myRandom = new Random();

        //agarramos 2 camiones random
        int camion1, camion2;

        camion1 = myRandom.nextInt(estado.getnCentros());

        do{
            camion2 = myRandom.nextInt(estado.getnCentros());
        }while (camion1 == camion2);

        //cogemos 2 gasolineras random dentro de la ruta de cada camion
        int pos1, pos2, gasolinera1, gasolinera2;

        do{
            pos1 = myRandom.nextInt(estado.getLongitudRutaCamion(camion1));
            gasolinera1 = estado.getGasolineraEnRuta(camion1, pos1);
        } while(gasolinera1 == -1);

        int nPeticiones1 = ((ArrayList<Integer>)estado.getCamiones().get(camion1).getRuta().get(pos1).getSecond()).size();
        int nPeticiones2;

        do{
            pos2 = myRandom.nextInt(estado.getLongitudRutaCamion(camion2));
            gasolinera2 = estado.getGasolineraEnRuta(camion2, pos2);
            nPeticiones2 = ((ArrayList<Integer>)estado.getCamiones().get(camion2).getRuta().get(pos2).getSecond()).size();
        }while ((gasolinera2 == -1) && (gasolinera1 == gasolinera2) && (nPeticiones1 == nPeticiones2));

        GasoEstado nuevoEstado = new GasoEstado(estado);
        nuevoEstado.intercambio(gasolinera1, gasolinera2, camion1, camion2);
        String S = ("a " + gasolinera1 + " e " + gasolinera2 + " ENTRE CAMION " + camion1 + " Y CAMION " + camion2);
        sucesores.add(new Successor(S, nuevoEstado));

        //indice camion
        //indice gasolinera 1
        //indice gasolinera 2

        int camion3, pos3, gasolinera3;

        camion3 = myRandom.nextInt(estado.getnCentros());

        do{
             pos3 = myRandom.nextInt(estado.getLongitudRutaCamion(camion3));
            gasolinera3 = estado.getGasolineraEnRuta(camion3, pos3);
        }while (gasolinera3 == -1);

        int gasolinera4;

        do{
            gasolinera4 = estado.getGasolineraEnRuta(camion3, pos3);
        }while (gasolinera4 == -1);

        GasoEstado nuevoEstado2 = new GasoEstado(estado);
        nuevoEstado2.intercambioGasolineraFueraDeRuta(gasolinera3, gasolinera4, camion3);
        String S1 = ("METEMOS " + gasolinera4 + " EN EL CAMION " + camion3 + " EN EL LUGAR DE  " + gasolinera3);
        //System.out.println(S1);
        sucesores.add(new Successor(S1, nuevoEstado2));
        return sucesores;

    }


}