package task5;

public class Dispatcher2 extends Proc {
	private QS Q1,Q2,Q3,Q4,Q5;
	private int c;

	public Dispatcher2(QS Q1, QS Q2, QS Q3, QS Q4, QS Q5) {
		this.Q1 = Q1;
		this.Q2 = Q2;
		this.Q3 = Q3;
		this.Q4 = Q4;
		this.Q5 = Q5;
		c = 0;
	}

	@Override
	public void TreatSignal(Signal sig) {
		switch (c){
		case 0:
			SignalList.SendSignal(sig.signalType, Q1, sig.arrivalTime);
			break;
		case 1:
			SignalList.SendSignal(sig.signalType, Q2, sig.arrivalTime);
			break;
		case 2:
			SignalList.SendSignal(sig.signalType, Q3, sig.arrivalTime);
			break;
		case 3:
			SignalList.SendSignal(sig.signalType, Q4, sig.arrivalTime);
			break;
		case 4:
			SignalList.SendSignal(sig.signalType, Q5, sig.arrivalTime);
			break;
		}
		c++;
		c = c%5;
	}

}
