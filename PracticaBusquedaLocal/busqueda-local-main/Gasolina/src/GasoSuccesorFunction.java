import IA.Gasolina.Gasolinera;
import IA.Gasolina.Gasolineras;
import aima.search.framework.Successor;
import aima.search.framework.SuccessorFunction;
import aima.util.Pair;

import java.sql.Array;
import java.util.ArrayList;

public class GasoSuccesorFunction implements SuccessorFunction {
    //PARA HILL CLIMBING --> TIENE QUE COMPROBAR TODOS LOS POSIBLES ESTADOS ---> GENERAR TODOS LOS SWAPS POSIBLES
    public ArrayList<Successor> getSuccessors(Object aState) {

        ArrayList<Successor> sucesores = new ArrayList<>();
        GasoEstado estado = (GasoEstado) aState;


        //System.out.println("Estado" + estado.getDistanciaRecorridaTotal());
        //System.out.println("AUX" + Aux.getDistanciaRecorridaTotal());
        int nCentros = estado.getnCentros();
        int nGasolineras = estado.getnGasolineras();

        for(int i = 0; i < nCentros; ++i) {
            int longitudRuta1 = estado.getLongitudRutaCamion(i);
            for(int g1 = 0;  g1 < longitudRuta1; ++g1) {
                int indiceGasolinera1 = estado.getGasolineraEnRuta(i, g1);

                if(indiceGasolinera1 != -1) {
                    //System.out.println("CAMION " + i + " LONG " + longitudRuta1 + " POS EN RUTA " + indiceGasolinera1);
                    for(int j = i; j < nCentros; ++j) {
                        if(j != i) {
                            int longitudRuta2 = estado.getLongitudRutaCamion(j);
                            for (int g2 = 0; g2 < longitudRuta2; ++g2) {
                                int indiceGasolinera2 = estado.getGasolineraEnRuta(j, g2);
                                int nPeticiones1 = ((ArrayList<Integer>)estado.getCamiones().get(i).getRuta().get(g1).getSecond()).size();
                                int nPeticiones2 = ((ArrayList<Integer>)estado.getCamiones().get(j).getRuta().get(g2).getSecond()).size();
                                if ((indiceGasolinera2 != -1) && nPeticiones1 == nPeticiones2) {
                                    GasoEstado nuevoEstado = new GasoEstado(estado);
                                    //System.out.println("Distancia Estado inicail " + estado.getDistanciaRecorridaTotal());
                                    //System.out.println("Distancia Nuevo Estado inicail " + nuevoEstado.getDistanciaRecorridaTotal());
                                    nuevoEstado.intercambio(indiceGasolinera1, indiceGasolinera2, i, j);

                                    //aux = new GasoEstado(nuevoEstado);
                                    // System.out.println("Distancia Nuevo Estado final " + nuevoEstado.getDistanciaRecorridaTotal());
                                    //System.out.println("Distancia Estado final " + estado.getDistanciaRecorridaTotal());
                                    //double v = GasoH.getHeuristicValue(nuevoEstado);
                                    String S = "INTERCAMBIO DE LAS GASOLINERAS " + indiceGasolinera1 + " Y " + indiceGasolinera2 + " ENTRE CAMION " + i + " Y CAMION " + j;
                                    //System.out.println(S);
                                    sucesores.add(sucesores.size(), new Successor(S, nuevoEstado));
                                }
                            }
                        }
                    }
                }
            }
        }
        for(int indiceCamion = 0; indiceCamion < nCentros; ++indiceCamion) {
            for(int indiceGasolinera1 = 0; indiceGasolinera1 < estado.getLongitudRutaCamion(indiceCamion); ++indiceGasolinera1) {
                if(estado.getGasolineraEnRuta(indiceCamion,indiceGasolinera1) != -1) {
                    int nPeticiones1 = ((ArrayList<Integer>) estado.getCamiones().get(indiceCamion).getRuta().get(indiceGasolinera1).getSecond()).size();
                    for(int indiceGasolinera2 = 0; indiceGasolinera2 < nGasolineras; ++indiceGasolinera2) {
                        int nPeticiones2 = estado.getNumPeticiones(indiceGasolinera2);
                        if (true) {
                            GasoEstado nuevoEstado = new GasoEstado(estado);
                            nuevoEstado.intercambioGasolineraFueraDeRuta(indiceGasolinera1,indiceGasolinera2,indiceCamion);
                            String S = "CAMIÓN: " +indiceCamion + " ENTRA " + indiceGasolinera2 + " SE VA " + indiceGasolinera1;
                            sucesores.add(sucesores.size(), new Successor(S, nuevoEstado));
                        }
                    }
                }


            }
        }
        return sucesores;
    }

    /*public List getSuccessors(Object estado) {
        ArrayList<Successor> sucesores = new ArrayList<>();
        GasoEstado gasoEstado = (GasoEstado) estado;
        //System.out.print(gasoEstado.capActualToString());
        for(int i = 0; i < gasoEstado.getnCentros(); ++i){
            //System.out.print("It "+i+ " - "+gasoEstado.getPrecio()+" - "+gasoEstado.capActualToString());
            for(int j = 0; j < gasoEstado.getnGasolineras(); ++j){
                GasoEstado nuevoGasoEstado = new GasoEstado(gasoEstado);
                if(nuevoGasoEstado.intercambio(i, j);){
                    StringBuffer S = new StringBuffer();
                    S.append("movido paquete "+i+ " a oferta "+j+"\n");
                    sucesores.add(new Successor(S.toString(), nuevoGasoEstado));
                }
            }
            for(int j = i +1; j < gasoEstado.paq.size() -1; ++j){
                GasoEstado nuevoGasoEstado = new GasoEstado(gasoEstado);
                if(nuevoGasoEstado.permutarPaquetes(i, j)){
                    StringBuffer S = new StringBuffer();
                    S.append("permutados paquetes "+i+ " y "+j+"\n");
                    sucesores.add(new Successor(S.toString(), nuevoGasoEstado));
                }
            }
        }
        //System.out.print(gasoEstado.getPrecio()+" - "+gasoEstado.capActualToString());
        return sucesores;
    }*/

}

