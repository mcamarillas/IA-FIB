import aima.basic.Agent;
import aima.search.framework.*;
import aima.search.informed.HillClimbingSearch;
import aima.search.informed.SimulatedAnnealingSearch;

import java.lang.reflect.Array;
import java.util.*;

import java.util.concurrent.TimeUnit;


public class Main {

    public static void main(String[] args) throws Exception {
        System.out.println("Introduce el numero de gasolineras:");
        Scanner S=new Scanner(System.in);
        int numGasolineras =  S.nextInt();
        System.out.println("Introduce el numero de centros:");
        int numCentros =  S.nextInt();
        System.out.println("Introduce la semilla:");
        int seed =  S.nextInt();
        System.out.println("Introduce el numero de km maximos:");
        int distMax =  S.nextInt();
        System.out.println("Introduce el numero de viajes maximos:");
        int viajesMax =  S.nextInt();
        System.out.println("Selecciona solucion inicial:");
        System.out.println(" 1. Solucion Inicial 1");
        System.out.println(" 2. Solucion Inicial 2 (random)");
        int solucion =  S.nextInt();
        System.out.println("Selecciona el Algoritmo:");
        System.out.println(" 1. Hill Climbing");
        System.out.println(" 2. Simulated Annealing");
        int algoritmo =  S.nextInt();

        long startTime = System.nanoTime();

        GasoEstado gasoEstado = new GasoEstado(numGasolineras, numCentros, seed, 1, distMax, viajesMax);

        if(solucion == 1) gasoEstado.initialSolution1();
        if(solucion == 2) gasoEstado.initialSolution2();
        gasoEstado.imprimeRutas();
        if(algoritmo==1) GasolineraHillClimbingSearch(gasoEstado);
        if(algoritmo==2) GasolineraSimulatedAnnealing(gasoEstado);

        long endTime = System.nanoTime();
        long timeElapsed = endTime - startTime;
        System.out.println("Execution time in milliseconds: " + timeElapsed / 1000000);

    }

    private static void GasolineraHillClimbingSearch(GasoEstado estado) {
        try {
            Problem problem;
            problem = new Problem(estado, new GasoSuccesorFunction(), new GasoGoalTest(), new GasoHeuristic());
            Search search = new HillClimbingSearch();
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
            System.out.println("\n" + ((GasoEstado) search.getGoalState()).toString());
            ((GasoEstado) search.getGoalState()).imprimeRutas();
            System.out.println("BENEFICIOS FINALES :" + ((((GasoEstado) search.getGoalState()).getPorcentajeGanancias()/100)*1000 - ((GasoEstado) search.getGoalState()).getDistanciaRecorridaTotal()*2));
           //System.out.println("PERDIDAS FINALES :" + ((GasoEstado) search.getGoalState()).getPerdidas());
            System.out.println("DISTANCIA TOTAL FINAL :" + ((GasoEstado) search.getGoalState()).getDistanciaRecorridaTotal());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void GasolineraSimulatedAnnealing(GasoEstado estado) {
        try {
            Problem problem;
            problem = new Problem(estado, new GasoSuccesorFunction2(), new GasoGoalTest(), new GasoHeuristic());
            Search search = new SimulatedAnnealingSearch(10000, 100, 5, 0.001);
            SearchAgent agent = new SearchAgent(problem, search);
            printInstrumentation(agent.getInstrumentation());
            printActions(agent.getActions());

            System.out.println("BENEFICIOS FINALES :" + ((((GasoEstado) search.getGoalState()).getPorcentajeGanancias()/100)*1000 - ((GasoEstado) search.getGoalState()).getDistanciaRecorridaTotal()*2));
            //System.out.println("PERDIDAS FINALES :" + ((GasoEstado) search.getGoalState()).getPerdidas());
            System.out.println("DISTANCIA TOTAL FINAL :" + ((GasoEstado) search.getGoalState()).getDistanciaRecorridaTotal());


        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private static void printActions(List actions) {
        for (Object o : actions) {
            String action = o.toString();
            System.out.println(action);
        }
    }

    private static void printInstrumentation(Properties properties) {
        Iterator keys = properties.keySet().iterator();
        while (keys.hasNext()) {
            String key = (String) keys.next();
            String property = properties.getProperty(key);
            System.out.println(key + " : " + property);
        }
    }
}