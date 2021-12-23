import IA.Gasolina.CentrosDistribucion;
import IA.Gasolina.Gasolineras;
import IA.Gasolina.Gasolinera;
import aima.util.Pair;

import java.util.Random;

import java.util.ArrayList;
// HOLA GUENO DIA
public class GasoEstado {
    private static int nGasolineras;
    private static int nCentros;
    private static int dMax;
    private static int vMax;
    private static int seed;
    private static int mult;
    private int porcentajeGanancias;
    private int porcentajeMaximo;
    private int perdidas;
    private int distanciaRecorridaTotal;

    private ArrayList<Gasolinera> gasolineras;

    private static CentrosDistribucion centroDistribucion;

    // Centro asignado a cada gasolinera
    // Pendiete de quitar
    private ArrayList<Integer> centrosAsignados;

    private ArrayList<Camion> camiones;

    //-------------------------------------------------CREADORA--------------------------------------------------------\\

    public GasoEstado(int numGasolineras, int numCentros, int seed, int mult, int distMax, int viajesMax) {
        nGasolineras = numGasolineras;
        nCentros = numCentros;
        dMax = distMax;
        vMax = viajesMax;
        this.seed = seed;
        this.mult = mult;
        centrosAsignados = new ArrayList<Integer>();
        porcentajeGanancias = 0;
        porcentajeMaximo = 0;
        distanciaRecorridaTotal = 0;
        perdidas = 0;

        for(int i = 0; i < nGasolineras; ++i) centrosAsignados.add(-1);

        camiones = new ArrayList<Camion> ();
        for(int i = 0; i < nCentros; ++i) {
            Camion c = new Camion(0,0,2,true);
            camiones.add(c);
        }

        gasolineras = new Gasolineras(nGasolineras,seed);
        centroDistribucion = new CentrosDistribucion(numCentros,mult,seed);
        calculaMaximoPorcentaje();
    }

    public GasoEstado(GasoEstado estado){
        nGasolineras = estado.getnGasolineras();
        nCentros = estado.getnCentros();
        dMax = estado.getdMax();
        vMax = estado.getvMax();
        ArrayList<Camion> c = estado.getCamiones();
        ArrayList<Camion> nc = new ArrayList<Camion>(nCentros);
        ArrayList<Gasolinera> g = new ArrayList<>(nGasolineras);
        ArrayList<Integer> p = new ArrayList<>();
        for(Gasolinera gaso : estado.getGasolineras()) g.add(gaso);
        for(int i = 0; i < nCentros; ++i) {
            ArrayList<Pair> ruta = new ArrayList<Pair> ();
            for(int j = 0; j < c.get(i).getRuta().size(); ++j) {
                ruta.add(j, c.get(i).getRuta().get(j));
            }
            Camion ca = new Camion(c.get(i).getDistancia(), c.get(i).getnViajes(), c.get(i).getnTanques(), c.get(i).isOperativo());
            ca.setRuta(ruta);
            nc.add(i, ca);
        }
        camiones = nc;
        seed = estado.getSeed();
        mult = estado.getMult();
        distanciaRecorridaTotal = estado.getDistanciaRecorridaTotal();
        perdidas = estado.getPerdidas();
        porcentajeGanancias = estado.getPorcentajeGanancias();
        porcentajeMaximo = estado.getPorcentajeMaximo();
        gasolineras = g;
        centrosAsignados = estado.centrosAsignados;

    }

    //-------------------------------------------------GETTERS---------------------------------------------------------\\

    public ArrayList<Gasolinera> getGasolineras() {
        return gasolineras;
    }

    public int getPorcentajeGanancias() {
        return porcentajeGanancias;
    }

    public int getnGasolineras() {
        return nGasolineras;
    }

    public int getnCentros() {
        return nCentros;
    }

    public int getPerdidas() {
        return (porcentajeMaximo - porcentajeGanancias);
    }

    public int getDistanciaRecorridaTotal() {
        return distanciaRecorridaTotal;
    }

    public int getLongitudRutaCamion(int nCentro) {
        return camiones.get(nCentro).getRuta().size();
    }

    public int getGasolineraEnRuta(int nCentro, int posRuta) {
        //System.out.println("Camion " + nCentro + " Posicion " + posRuta);
        //imprimeRutas();
        return (Integer)camiones.get(nCentro).getRuta().get(posRuta).getFirst();
    }

    public int getSeed() {
        return seed;
    }

    public int getdMax() {
        return dMax;
    }

    public int getvMax() {
        return vMax;
    }

    public int getMult() {
        return mult;
    }

    public int getPorcentajeMaximo() {
        return porcentajeMaximo;
    }

    public int getNumPeticiones(int indiceGasolinera) {
        return gasolineras.get(indiceGasolinera).getPeticiones().size();
    }

    public ArrayList<Camion> getCamiones() {
        return camiones;
    }

    //-----------------------------------------------CONSULTORAS-------------------------------------------------------\\

    public boolean isGoalState() {
        return false;
    }

    //-----------------------------------------FUNCIONES AUXILIARES---------------------------------------------------\\

    private int calculaDistancia(int indiceGasolinera, int indiceCamion) {
        int xg = gasolineras.get(indiceGasolinera).getCoordX();
        int yg = gasolineras.get(indiceGasolinera).getCoordY();
        int xc = centroDistribucion.get(indiceCamion).getCoordX();
        int yc = centroDistribucion.get(indiceCamion).getCoordY();
        return Math.abs(xc - xg) + Math.abs(yc - yg);
    }

    private int calculaDistanciaGasolineras(int indiceGasolinera1, int indiceGasolinera2) {
        int xg1 = gasolineras.get(indiceGasolinera1).getCoordX();
        int yg1 = gasolineras.get(indiceGasolinera1).getCoordY();
        int xg2 = gasolineras.get(indiceGasolinera2).getCoordX();
        int yg2 = gasolineras.get(indiceGasolinera2).getCoordY();
        return Math.abs(xg2 - xg1) + Math.abs(yg2 - yg1);
    }

    private void subministraCamion(int indiceGasolinera, int indiceCamion) {
        camiones.get(indiceCamion).addParadaRuta(-1, new ArrayList<>());
        int d = camiones.get(indiceCamion).getDistancia() + calculaDistancia(indiceGasolinera, indiceCamion);
        int v = camiones.get(indiceCamion).getnViajes() + 1;
        boolean o = (d <= dMax) && (v < vMax);
        distanciaRecorridaTotal += calculaDistancia(indiceGasolinera, indiceCamion);
        camiones.get(indiceCamion).setCamion(d,v,2, o);
        //System.out.println("Distancia al pasar por el centro :" + d + " bool = " + o);
    }

    private void actualizaCamiones(int indice, int km, int indiceG, ArrayList<Integer> peticiones) {
        int d = camiones.get(indice).getDistancia() + km;
        int v = camiones.get(indice).getnViajes();
        boolean o = camiones.get(indice).isOperativo() && (d < dMax) && camiones.get(indice).getnTanques() > 0;
        distanciaRecorridaTotal += km;
        camiones.get(indice).getRuta().add(new Pair(indiceG, peticiones));
        camiones.get(indice).setCamion(d, v, camiones.get(indice).getnTanques(), o);
    }

    private void actualizaPeticiones(int indiceGasolinera, int indiceCamio, ArrayList<Integer> peticiones) {
        int numTanques = camiones.get(indiceCamio).getnTanques();
        if(gasolineras.get(indiceGasolinera).getPeticiones().size() > 0 && numTanques > 0) {
            int dias = gasolineras.get(indiceGasolinera).getPeticiones().get(0);
            porcentajeGanancias += calculaPorcentaje(dias);
            perdidas -= calculaPorcentaje(dias);
            camiones.get(indiceCamio).actualizaTanques(-1);
            peticiones.add(dias);
            gasolineras.get(indiceGasolinera).getPeticiones().remove(0);
            actualizaPeticiones(indiceGasolinera, indiceCamio, peticiones);
            //System.out.println("Centro Asignado a la gasolinera " + indiceGasolinera + ": " + centrosAsignados.get(indiceCamio));
        }
    }

    public void sumaDist() {

        for(int i = 0; i < nCentros; ++i) {
            ArrayList<Pair> ruta = camiones.get(i).getRuta();
            int d = calculaDistancia((Integer)(ruta.get(0).getFirst()), i);
            for (int j = 1; j < ruta.size(); ++j) {
                if((Integer)ruta.get(j-1).getFirst() == -1) d += calculaDistancia((Integer)ruta.get(j).getFirst(), i);
                else if((Integer)ruta.get(j).getFirst() == -1) d+= calculaDistancia((Integer)ruta.get(j-1).getFirst(), i);
                else d += calculaDistanciaGasolineras((Integer)ruta.get(j).getFirst(), (Integer)ruta.get(j-1).getFirst());
                //System.out.println("EL CAMION " + i + " HA RECORRIDO " + d + " KM");
            }
            //System.out.println("EL CAMION " + i +  " HA RECORRIDO TEORICAMENTE " +  camiones.get(i).getDistancia());
        }

    }

    private void asignaCentro(int indiceGasolinera, int indiceCentro) {
        centrosAsignados.set(indiceGasolinera,(Integer) indiceCentro);
    }

    private int calculaPorcentaje(int dias) {
        if(dias == 0) return 102;
        else return (int) (100 - Math.pow(2, dias));
    }

    private void calculaMaximoPorcentaje() {
        for(int i = 0; i < nGasolineras; ++i) {
            for(int j = 0; j < gasolineras.get(i).getPeticiones().size(); ++j) {
                int dias = gasolineras.get(i).getPeticiones().get(j);
                porcentajeMaximo += calculaPorcentaje(dias);
                // System.out.println("PM " + porcentajeMaximo + " gasolinera " + i + " dias " + dias);
            }
        }
    }

    private void actualizaEstado(int indiceGasolinera, int indiceCentro, int distancia) {
        //asignaCentro(indiceGasolinera, indiceCentro);
        ArrayList<Integer> peticiones = new ArrayList<>();
        actualizaPeticiones(indiceGasolinera, indiceCentro, peticiones);
        actualizaCamiones(indiceCentro, distancia, indiceGasolinera, peticiones);
    }

    private int calculaDistanciaAnterior(int indiceGasolinera, int indiceCamion, int posicionEnRuta){
        int distanciaPreviaGasolinera = 0;
        if (posicionEnRuta != 0) {
            int gasolineraAnterior1 = (Integer)camiones.get(indiceCamion).getRuta().get(posicionEnRuta-1).getFirst();
            if(gasolineraAnterior1 != -1) {
                distanciaPreviaGasolinera = calculaDistanciaGasolineras(indiceGasolinera, gasolineraAnterior1);
            }
            else{
                distanciaPreviaGasolinera = calculaDistancia(indiceGasolinera, indiceCamion);
            }
        }
        return distanciaPreviaGasolinera;

    }

    private int calculaDistanciaPosterior(int indiceGasolinera, int indiceCamion, int posicionEnRuta){
        int distanciaPreviaGasolinera = 0;
        if (posicionEnRuta+1 < getLongitudRutaCamion(indiceCamion)) {
            //System.out.println(getLongitudRutaCamion(indiceCamion) + "      " + posicionEnRuta);
            int gasolineraPosterior = (Integer)camiones.get(indiceCamion).getRuta().get(posicionEnRuta+1).getFirst();
            if(gasolineraPosterior != -1) {
                distanciaPreviaGasolinera = calculaDistanciaGasolineras(indiceGasolinera, gasolineraPosterior);
            }
            else{
                distanciaPreviaGasolinera = calculaDistancia(indiceGasolinera, indiceCamion);
            }
        }
        return distanciaPreviaGasolinera;

    }


    //-------------------------------------------------PRINTS---------------------------------------------------------\\

    public void imprimeCentrosAsignados() {
        for(int i = 0; i < nGasolineras; ++i) {
            System.out.println("Centro Asignado a la gasolinera " + i + ": " + centrosAsignados.get(i));
        }
    }

    public void imprimeGasolineras() {
        for(int i = 0; i < nGasolineras; ++i) {
            System.out.println("Gasolinera " + i + ":");
            System.out.println("X: " + gasolineras.get(i).getCoordX());
            System.out.println("Y: " + gasolineras.get(i).getCoordY());
            System.out.println("Peticiones:");
            int size = gasolineras.get(i).getPeticiones().size();
            for(int j = 0; j < size; ++j) {
                System.out.println(gasolineras.get(i).getPeticiones().get(j));
            }
        }
    }

    public void imprimeCentrosDistribucion() {
        for(int i = 0; i < nCentros; ++i) {
            System.out.println("Centro de Distribucion " + i + ":");
            System.out.println("X: " + centroDistribucion.get(i).getCoordX());
            System.out.println("Y: " + centroDistribucion.get(i).getCoordY());
        }
    }

    public void imprimeRutas() {
        for(int i = 0; i < nCentros; ++i) {
            int n = camiones.get(i).getRuta().size();
            System.out.println("Ruta del camion " + i + " :");
            for(int j = 0; j < n; ++j) System.out.print(camiones.get(i).getRuta().get(j) + " ");
            int m = camiones.get(i).getRuta().size();
            System.out.println();
            System.out.println(camiones.get(i).getDistancia());
            System.out.println();
        }
        System.out.println();
    }


    public void muestraDist() {
        for(int i = 0; i < nCentros; ++i) {
            System.out.println("El camion " + i + " ha recorrido " + camiones.get(i).getDistancia());
        }
    }

    //----------------------------------------------OPERADORES--------------------------------------------------------\\

    /*
       Condiciones de Aplicabilidad:
            -   La gasolinera1 existe en la ruta del camion1
            -   La gasolinera2 existe en la ruta del camion2
            -   Los tanques del camion1 - las peticiones de la gasolinera1 + las peticiones de la gasolinera2 han de ser <= 2
            -   Los tanques del camion2 - las peticiones de la gasolinera2 + las peticiones de la gasolinera1 han de ser <= 2

       Funcion de transformacion:
            El camion1 quita de su ruta la gasolinera1 y añade en su lugar la gasolinera2 y
            el camion2 quita de su ruta la gasolinera2 y añade en su lugar la gasolinera1

     */
    public void intercambio(int indiceGasolinera1, int indiceGasolinera2, int indiceCamion1, int indiceCamion2) {
        if (indiceGasolinera1 != -1 && indiceGasolinera2 != -1) {
            int posicionEnRuta1 = camiones.get(indiceCamion1).obtenPosicionDeGasolineraEnRuta(indiceGasolinera1);
            int posicionEnRuta2 = camiones.get(indiceCamion2).obtenPosicionDeGasolineraEnRuta(indiceGasolinera2);
            //resta distancias antiguas al total
            int distanciaPreviaGasolinera1 = calculaDistanciaAnterior(indiceGasolinera1, indiceCamion1, posicionEnRuta1);
            int distanciaPreviaGasolinera2 = calculaDistanciaAnterior(indiceGasolinera2, indiceCamion2, posicionEnRuta2);
            int distanciaPosteriorGasolinera1 = calculaDistanciaPosterior(indiceGasolinera1, indiceCamion1, posicionEnRuta1);
            int distanciaPosteriorGasolinera2 = calculaDistanciaPosterior(indiceGasolinera2, indiceCamion2, posicionEnRuta2);
            distanciaRecorridaTotal -= (distanciaPosteriorGasolinera1 +distanciaPreviaGasolinera1 +
                    distanciaPosteriorGasolinera2 + distanciaPreviaGasolinera2);
            //suma las nuevas al total
            int nuevaDistanciaPreviaGasolinera1 = calculaDistanciaAnterior(indiceGasolinera2, indiceCamion1, posicionEnRuta1);
            int nuevaDistanciaPreviaGasolinera2 = calculaDistanciaAnterior(indiceGasolinera1, indiceCamion2, posicionEnRuta2);
            int nuevaDistanciaPosteriorGasolinera1 = calculaDistanciaPosterior(indiceGasolinera2, indiceCamion1, posicionEnRuta1);
            int nuevaDistanciaPosteriorGasolinera2 = calculaDistanciaPosterior(indiceGasolinera1, indiceCamion2, posicionEnRuta2);
            //System.out.println("Distancia vieja " + distanciaRecorridaTotal);
            distanciaRecorridaTotal += nuevaDistanciaPosteriorGasolinera1 + nuevaDistanciaPreviaGasolinera1 +
                    nuevaDistanciaPosteriorGasolinera2 + nuevaDistanciaPreviaGasolinera2;
            //System.out.println("Distancia restada " + distanciaRecorridaTotal);
            //actualiza distancia camion 1
            camiones.get(indiceCamion1).addDistancia(nuevaDistanciaPreviaGasolinera1 + nuevaDistanciaPosteriorGasolinera1 -
                    distanciaPosteriorGasolinera1 - distanciaPreviaGasolinera1);

            //actualiza distancia camion 2
            camiones.get(indiceCamion2).addDistancia(nuevaDistanciaPreviaGasolinera2 + nuevaDistanciaPosteriorGasolinera2 -
                    distanciaPosteriorGasolinera2 - distanciaPreviaGasolinera2);
            Pair p1 = new Pair(camiones.get(indiceCamion2).getRuta().get(posicionEnRuta2).getFirst(), camiones.get(indiceCamion2).getRuta().get(posicionEnRuta2).getSecond());
            Pair p2 = new Pair(camiones.get(indiceCamion1).getRuta().get(posicionEnRuta1).getFirst(), camiones.get(indiceCamion1).getRuta().get(posicionEnRuta1).getSecond());
            camiones.get(indiceCamion1).setRuta(posicionEnRuta1, p1);
            camiones.get(indiceCamion2).setRuta(posicionEnRuta2, p2);

            //System.out.println("Distancia nueva " + distanciaRecorridaTotal);
        }
    }

    /*
       Condiciones de Aplicabilidad:
            - La gasolinera tiene al menos una petición
            -   La gasolineraPosterior existe en la ruta del camion
            -   Los tanques del camion + las peticiones de la gasolineraPosterior + las peticiones de la gasolineraAInsetrar han de ser <= 2

       Funcion de transformacion:
            El camión añade en su ruta la gasolineraAInsertar en la posición anterior a GasolineraPosterior

     */
    public void insertarGasolineraARuta(int indiceCamion, int indiceGasolineraAInsetrar) {

        int size = camiones.get(indiceCamion).getRuta().size();
        int distancia = calculaDistancia(indiceGasolineraAInsetrar,indiceCamion);
        int indiceGasolineraAnterior = -1;
        if(size != 0) indiceGasolineraAnterior  = (Integer)camiones.get(indiceCamion).getRuta().get(size -1).getFirst();

        // Último elemento de la ruta es el centro
        if(indiceGasolineraAnterior == -1) {
            // La gasolinera tiene 2 o más peticiones
            if (gasolineras.get(indiceGasolineraAInsetrar).getPeticiones().size() > 1) {
                if (2 * distancia + camiones.get(indiceCamion).getDistancia() < dMax) {
                    actualizaEstado(indiceGasolineraAInsetrar, indiceCamion, distancia);
                    subministraCamion(indiceGasolineraAInsetrar, indiceCamion);
                }
            }
            // La gasolinera tiene 1 peticiones
            else if (gasolineras.get(indiceGasolineraAInsetrar).getPeticiones().size() == 1) {
                if (2 * distancia + camiones.get(indiceCamion).getDistancia() < dMax) {
                    actualizaEstado(indiceGasolineraAInsetrar, indiceCamion, distancia);
                    camiones.get(indiceCamion).addDistancia(distancia);
                }
            }
        }
        // Último elemento de la ruta es una gasolinera y la gasolinera a insertar tiene 1 petición
        else if (gasolineras.get(indiceGasolineraAInsetrar).getPeticiones().size() < 2 && indiceGasolineraAnterior != -1) {
                int distanciaAnterior = calculaDistancia(indiceGasolineraAnterior,indiceCamion);
                if (2 * distancia + camiones.get(indiceCamion).getDistancia() - distanciaAnterior < dMax) {
                    // Restamos distancia entre camión y gasolineraAnterior para que no vuelva al centro
                    camiones.get(indiceCamion).addDistancia(-distanciaAnterior);
                    actualizaEstado(indiceGasolineraAInsetrar, indiceCamion, distancia);
                    camiones.get(indiceCamion).addDistancia(distancia);
                }
            }

    }

    void intercambioGasolineraFueraDeRuta(int indiceGasolinera1, int indiceGasolinera2, int indiceCamion1) {
        int posicionEnRuta1 = camiones.get(indiceCamion1).obtenPosicionDeGasolineraEnRuta(indiceGasolinera1);
        int numPeticionesGasolinera1 = ((ArrayList<Integer>)camiones.get(indiceCamion1).getRuta().get(posicionEnRuta1).getSecond()).size();
        int numPeticionesGasolinera2 = gasolineras.get(indiceGasolinera2).getPeticiones().size();
        if (numPeticionesGasolinera1 == numPeticionesGasolinera2) {

            //resta distancias antiguas al total
            int distanciaPreviaGasolinera1 = calculaDistanciaAnterior(indiceGasolinera1, indiceCamion1, posicionEnRuta1);
            int distanciaPosteriorGasolinera1 = calculaDistanciaPosterior(indiceGasolinera1, indiceCamion1, posicionEnRuta1);
            distanciaRecorridaTotal -= (distanciaPosteriorGasolinera1 +distanciaPreviaGasolinera1);
            //suma las nuevas al total
            int nuevaDistanciaPreviaGasolinera1 = calculaDistanciaAnterior(indiceGasolinera2, indiceCamion1, posicionEnRuta1);
            int nuevaDistanciaPosteriorGasolinera1 = calculaDistanciaPosterior(indiceGasolinera2, indiceCamion1, posicionEnRuta1);
            //System.out.println("Distancia vieja " + distanciaRecorridaTotal);
            distanciaRecorridaTotal += nuevaDistanciaPosteriorGasolinera1 + nuevaDistanciaPreviaGasolinera1;
            //System.out.println("Distancia restada " + distanciaRecorridaTotal);
            //actualiza distancia camion 1
            int nuevaDist = nuevaDistanciaPreviaGasolinera1 + nuevaDistanciaPosteriorGasolinera1 -
                    distanciaPosteriorGasolinera1 - distanciaPreviaGasolinera1;

            //quitar vieja
            ArrayList<Integer> petViejas = gasolineras.get(indiceGasolinera1).getPeticiones();
            for(Integer i: (ArrayList<Integer>)camiones.get(indiceCamion1).getRuta().get(indiceGasolinera1).getSecond()) {
                porcentajeGanancias -= calculaPorcentaje(i);
                perdidas += calculaPorcentaje(i);
                petViejas.add(i);
            }

            //Agregar nueva gasolinera
            ArrayList<Integer> peticiones = new ArrayList<>();
            actualizaPeticiones(indiceGasolinera2, indiceCamion1, peticiones);
            for(Integer i: peticiones) {
                porcentajeGanancias += calculaPorcentaje(i);
                perdidas -= calculaPorcentaje(i);
            }
            actualizaCamiones(indiceCamion1, nuevaDist, indiceGasolinera2, peticiones);


            camiones.get(indiceCamion1).getRuta().set(posicionEnRuta1,new Pair(indiceGasolinera2, peticiones));
            gasolineras.get(indiceGasolinera1).setPeticiones(petViejas);
        }

    }




    //------------------------------------------SOLUCIONES INICIALES--------------------------------------------------\\

    // Asigna a cada gasolinera el centro más cercano siempre y cuando el camion de dicho centro este operativo
    void initialSolution1() {
        for (int indiceGasolinera = 0; indiceGasolinera < nGasolineras; ++indiceGasolinera) {
            // Gasolineras con 2 o más peticiones
            if (gasolineras.get(indiceGasolinera).getPeticiones().size() > 1) {
                int distanciaMinima = dMax;
                int indiceCentroCercano = 0;
                for (int indiceCentro = 0; indiceCentro < nCentros; ++indiceCentro) {
                    if (camiones.get(indiceCentro).isOperativo()) {
                        int distancia = calculaDistancia(indiceGasolinera, indiceCentro);
                        if (distancia < distanciaMinima && 2 * distancia + camiones.get(indiceCentro).getDistancia() <= 640) {
                            distanciaMinima = distancia;
                            indiceCentroCercano = indiceCentro;
                        }
                    }
                }
                if (camiones.get(indiceCentroCercano).isOperativo()) {
                    actualizaEstado(indiceGasolinera, indiceCentroCercano, distanciaMinima);
                    subministraCamion(indiceGasolinera, indiceCentroCercano);
                    //System.out.println("AL CAMION " + indiceCentroCercano + " HA RECORRIDO " + camiones.get(indiceCentroCercano).getDistancia());

                }
            }
        }
        for (int indiceGasolinera = 0; indiceGasolinera < nGasolineras; ++indiceGasolinera) {
            // Gasolineras con 1 petición
            if (gasolineras.get(indiceGasolinera).getPeticiones().size() == 1) {
                int distanciaMinima = dMax;
                int indiceCentroCercano = 0;
                if (gasolineras.get(indiceGasolinera).getPeticiones().size() != 0) {
                    for (int indiceCentro = 0; indiceCentro < nCentros; ++indiceCentro) {
                        if (camiones.get(indiceCentro).isOperativo()) {
                            int indiceG = camiones.get(indiceCentro).getRuta().size() - 1;
                            int distanciaAnterior;
                            int distancia = calculaDistancia(indiceGasolinera, indiceCentro);
                            if(indiceG != -1 && (Integer)camiones.get(indiceCentro).getRuta().get(indiceG).getFirst() != -1) {
                                distanciaAnterior = calculaDistanciaGasolineras(indiceGasolinera, (Integer)camiones.get(indiceCentro).getRuta().get(indiceG).getFirst());
                            }
                            else distanciaAnterior = distancia;
                            if (distancia < distanciaMinima && distanciaAnterior + distancia + camiones.get(indiceCentro).getDistancia() <= 640) {
                                distanciaMinima = distanciaAnterior;
                                indiceCentroCercano = indiceCentro;
                            }
                        }
                    }
                    if (camiones.get(indiceCentroCercano).isOperativo()) {
                        actualizaEstado(indiceGasolinera, indiceCentroCercano, distanciaMinima);
                        if (camiones.get(indiceCentroCercano).getnTanques() == 0)
                            subministraCamion(indiceGasolinera, indiceCentroCercano);
                    }
                }
            }
        }
        // Sumar distancia de vuelta para las rutas que acaban con una gasolinera
        for (int i = 0; i < nCentros; ++i) {
            if (camiones.get(i).getRuta().size() > 0) {
                int ultimaGasolineraDeRuta = (Integer)camiones.get(i).getRuta().get(camiones.get(i).getRuta().size() - 1).getFirst();
                if (ultimaGasolineraDeRuta != -1) {
                    subministraCamion(ultimaGasolineraDeRuta,i);
                }
            }
        }
        //System.out.println("MaxGanancias " + porcentajeMaximo + " GananciasTrayecto: " + porcentajeGanancias);
        perdidas = (porcentajeMaximo - porcentajeGanancias);
        //System.out.println("Pérdidas " + perdidas);
    }

void initialSolution2() {
        for (int indiceGasolinera = 0; indiceGasolinera < nGasolineras; ++indiceGasolinera) {
            // Gasolineras con 2 o más peticiones
            if (gasolineras.get(indiceGasolinera).getPeticiones().size() > 1) {
                int distancia = 0;
                int indiceCentro = -1;
                if (gasolineras.get(indiceGasolinera).getPeticiones().size() != 0) {
                    boolean seleccionado = false;
                    int count = 0;
                    while (!seleccionado && count < 2 * nCentros) {
                        Random rand = new Random();
                        indiceCentro = rand.nextInt(nCentros);
                        if (camiones.get(indiceCentro).isOperativo()) {
                            distancia = calculaDistancia(indiceGasolinera, indiceCentro);
                            if (2 * distancia + camiones.get(indiceCentro).getDistancia() <= dMax) {
                                seleccionado = true;
                            }
                        }
                        ++count;
                    }
                    if (camiones.get(indiceCentro).isOperativo()) {
                        actualizaEstado(indiceGasolinera, indiceCentro, distancia);
                        subministraCamion(indiceGasolinera, indiceCentro);
                    }
                }
            }
        }
        for (int indiceGasolinera = 0; indiceGasolinera < nGasolineras; ++indiceGasolinera) {
            // Gasolineras con 1 petición
            if (gasolineras.get(indiceGasolinera).getPeticiones().size() == 1) {
                int distanciaMinima = dMax;
                int indiceCentro = -1;
                if (gasolineras.get(indiceGasolinera).getPeticiones().size() != 0) {
                    boolean seleccionado = false;
                    int count = 0;
                    while (!seleccionado && count < 2 * nCentros) {
                        Random rand = new Random();
                        indiceCentro = rand.nextInt(nCentros);
                        int indiceG = camiones.get(indiceCentro).getRuta().size() - 1;
                        int distanciaAnterior;
                        int distancia = calculaDistancia(indiceGasolinera, indiceCentro);
                        if (indiceG != -1 && (Integer) camiones.get(indiceCentro).getRuta().get(indiceG).getFirst() != -1) {
                            distanciaAnterior = calculaDistanciaGasolineras(indiceGasolinera, (Integer) camiones.get(indiceCentro).getRuta().get(indiceG).getFirst());
                        } else distanciaAnterior = distancia;
                        if (distancia < distanciaMinima && distanciaAnterior + distancia + camiones.get(indiceCentro).getDistancia() <= 640) {
                            distanciaMinima = distanciaAnterior;
                            indiceCentro = indiceCentro;
                        }
                        ++count;
                    }
                }
                if (camiones.get(indiceCentro).isOperativo()) {
                    actualizaEstado(indiceGasolinera, indiceCentro, distanciaMinima);
                    if (camiones.get(indiceCentro).getnTanques() == 0)
                        subministraCamion(indiceGasolinera, indiceCentro);
                }
            }
        }
        // Sumar distancia de vuelta para las rutas que acaban con una gasolinera
        for (int i = 0; i < nCentros; ++i) {
            if (camiones.get(i).getRuta().size() > 0) {
                int ultimaGasolineraDeRuta = (Integer) camiones.get(i).getRuta().get(camiones.get(i).getRuta().size() - 1).getFirst();
                if (ultimaGasolineraDeRuta != -1) {
                    subministraCamion(ultimaGasolineraDeRuta, i);
                }
            }
        }
        //System.out.println("MaxGanancias " + porcentajeMaximo + " GananciasTrayecto: " + porcentajeGanancias);
        perdidas = (porcentajeMaximo - porcentajeGanancias);
        //System.out.println("Pérdidas " + perdidas);
    }

}
