package task5;

import java.util.*;
import java.io.*;

// This class defines a simple queuing system with one server. It inherits Proc so that we can use time and the
// signal names without dot notation
class QS extends Proc{
	public long numberInQueue = 0, accumulated = 0, noMeasurements = 0;
	public Proc sendTo;
	Random slump = new Random();

	public void TreatSignal(Signal x){
		switch (x.signalType){

			case ARRIVAL:{
				numberInQueue++;
				if (numberInQueue == 1){
					SignalList.SendSignal(READY,this, time - (1/0.5)*Math.log(slump.nextDouble()));
				}
			} break;

			case READY:{
				numberInQueue--;
				if (sendTo != null){
					SignalList.SendSignal(ARRIVAL, sendTo, time);
				}
				if (numberInQueue > 0){
					SignalList.SendSignal(READY, this, time - (1/0.5)*Math.log(slump.nextDouble()));
				}
			} break;

			case MEASURE:{
				noMeasurements++;
				accumulated = accumulated + numberInQueue;
				SignalList.SendSignal(MEASURE, this, time + 2*slump.nextDouble());
			} break;
		}
	}
}