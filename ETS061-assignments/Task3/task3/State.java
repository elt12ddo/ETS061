package task3;

import java.util.*;
import java.io.*;

class State{
	public int numberInQueue = 0, accumulated = 0, noMeasurements = 0, numberInQueue2 = 0, accumulated2 = 0, nbrOfArrivals = 0;
	public ArrayList<Double> start = new ArrayList<Double>(), stop = new ArrayList<Double>();
	

	Random slump = new Random();
	SimpleFileWriter W = new SimpleFileWriter("./Task3/number.m", false);
	
	public void TreatEvent(Event x){
		switch (x.eventType){
			case G.ARRIVAL:{
				start.add(new Double(G.time));
				nbrOfArrivals++;
				numberInQueue++;
				if (numberInQueue == 1){
					EventList.InsertEvent(G.READY, G.time - (1.0)*Math.log(1.0-slump.nextDouble()));
				}
				EventList.InsertEvent(G.ARRIVAL, G.time - (2.0)*Math.log(1.0-slump.nextDouble()));//change here
			} break;
			case G.READY:{
				numberInQueue--;
				numberInQueue2++;
				if(numberInQueue2 == 1){
					EventList.InsertEvent(G.READY2, G.time - (1.0)*Math.log(1.0-slump.nextDouble()));
				}
				if (numberInQueue > 0){
					EventList.InsertEvent(G.READY, G.time - (1.0)*Math.log(1.0-slump.nextDouble()));
				}
			} break;
			case G.MEASURE:{
				accumulated = accumulated + numberInQueue;
				accumulated2 = accumulated2 + numberInQueue2;
				noMeasurements++;
				EventList.InsertEvent(G.MEASURE, G.time - (5.0)*Math.log(1.0-slump.nextDouble()));
				W.println(String.valueOf(numberInQueue));
			} break;
			case G.READY2:{
				stop.add(new Double(G.time));
				numberInQueue2--;
				if (numberInQueue2 > 0){
					EventList.InsertEvent(G.READY2, G.time - (1.0)*Math.log(1.0-slump.nextDouble()));
				}
			} break;
		}
	}
}