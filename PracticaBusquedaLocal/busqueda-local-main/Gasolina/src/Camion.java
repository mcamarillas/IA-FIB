import aima.util.Pair;

import java.util.ArrayList;

public class Camion {
    private int distancia;
    private int nViajes;
    private int nTanques;
    private boolean operativo;
    private ArrayList<Pair> ruta;

    public Camion(int d, int n, int nT, boolean o) {
        distancia = d;
        nViajes = n;
        nTanques = nT;
        operativo = o;
        ruta = new ArrayList<Pair>();
    }

    public void setCamion(int d, int n, int nT, boolean o) {
        distancia = d;
        nViajes = n;
        nTanques = nT;
        operativo = o;
    }

    public int obtenPosicionDeGasolineraEnRuta(int numGasolinera) {
        int k = 0;
        for (int i = 0; i < ruta.size(); ++i) if ((Integer)ruta.get(i).getFirst() == numGasolinera) k = i;
        return k;
    }


    public int getDistancia() {
        return distancia;
    }

    public int getnViajes() {
        return nViajes;
    }

    public int getnTanques() {
        return nTanques;
    }

    public boolean isOperativo() {
        return operativo;
    }

    public ArrayList<Pair> getRuta() {
        return ruta;
    }

    public void setRuta(ArrayList<Pair> ruta) {
        this.ruta = ruta;
    }

    public void addDistancia(int d) {
        distancia += d;
    }

    public void addParadaRuta(int g, ArrayList<Integer> p) {
        ruta.add(new Pair(g,p));
    }

    public void actualizaTanques(int n) {
        nTanques += n;
    }

    public void setRuta(int posRuta, Pair p) {
        ruta.set(posRuta, p);
    }
}