import aima.search.framework.GoalTest;

public class GasoGoalTest implements GoalTest {
    public boolean isGoalState(Object aState) {
        GasoEstado gasoEstado = (GasoEstado) aState;
        return (gasoEstado.isGoalState());
    }
}
