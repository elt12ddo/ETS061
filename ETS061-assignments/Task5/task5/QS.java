package task5;

import java.util.*;
import java.io.*;

// This class defines a simple queuing system with one server. It inherits Proc so that we can use time and the
// signal names without dot notation
class QS extends Proc{
	public int numberInQueue = 0, accumulated = 0, noMeasurements = 0,nbrOfArrivals = 0;
	public Proc sendTo;
	public ArrayList<Double> arrivalTimes = new ArrayList<Double>(), readyTimes = new ArrayList<Double>();
	Random slump = new Random();

	public void TreatSignal(Signal x){
		switch (x.signalType){
			case ARRIVAL:{
				arrivalTimes.add(new Double(x.arrivalTime));
				numberInQueue++;
				nbrOfArrivals++;
				if (numberInQueue == 1){
					double temp1 = time - (0.5)*Math.log(1.0-slump.nextDouble());
					SignalList.SendSignal(READY,this, temp1);
					readyTimes.add(new Double(temp1));
				}
			} break;

			case READY:{
				numberInQueue--;
				if (sendTo != null){
					SignalList.SendSignal(ARRIVAL, sendTo, time);
				}
				if (numberInQueue > 0){
					double temp2 = time - (0.5)*Math.log(1.0-slump.nextDouble());
					SignalList.SendSignal(READY, this, temp2);
					readyTimes.add(new Double(temp2));
				}
			} break;

			case MEASURE:{
				noMeasurements++;
				accumulated = accumulated + numberInQueue;
				SignalList.SendSignal(MEASURE, this, time + 0.5*slump.nextDouble());
			} break;
		}
	}
}