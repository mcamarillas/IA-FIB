import aima.search.framework.HeuristicFunction;

public class GasoHeuristic implements HeuristicFunction {
    public double getHeuristicValue(Object estado) {
        GasoEstado gasoEstado = (GasoEstado) estado;
        return gasoEstado.getDistanciaRecorridaTotal()+gasoEstado.getPerdidas();
    }
}
