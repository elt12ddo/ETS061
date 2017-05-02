package task5;
import java.util.ArrayList;

public class Dispatcher3 extends Proc {
	private ArrayList<QS> list;

	public Dispatcher3(QS Q1, QS Q2, QS Q3, QS Q4, QS Q5) {
		list = new ArrayList<QS>();
		list.add(Q1);
		list.add(Q2);
		list.add(Q3);
		list.add(Q4);
		list.add(Q5);
	}

	@Override
	public void TreatSignal(Signal sig) {
		QS shortest =list.get(0);
		for(int k = 1; k < 5; k++){
			if(list.get(k).numberInQueue < shortest.numberInQueue){
				shortest = list.get(k);
			}
		}
		SignalList.SendSignal(sig.signalType,shortest,sig.arrivalTime);
	}
}