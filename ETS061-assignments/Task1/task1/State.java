package task1;

import java.util.*;
import java.io.*;

class State{
	public int numberInQueue = 0, accumulated = 0, noMeasurements = 0, numberInQueue2 = 0, nbrRejected = 0, accumulated2 = 0, nbrOfArrivals = 0;
	

	Random slump = new Random();
	SimpleFileWriter W = new SimpleFileWriter("./Task1/number.m", false);
	
	public void TreatEvent(Event x){
		switch (x.eventType){
			case G.ARRIVAL:{
				nbrOfArrivals++;
				//System.out.print("K ");
				if(numberInQueue >= 10){
					//System.out.println("to many in q");
					nbrRejected++;
				}else{
					numberInQueue++;
					//System.out.println("in q: "+numberInQueue);
				}
				if (numberInQueue == 1){
					EventList.InsertEvent(G.READY, G.time + (-2.1)*Math.log(1.0-slump.nextDouble()));//OBS exponential inte poisson dvs ej delat med
				}
				EventList.InsertEvent(G.ARRIVAL, G.time + 1.0);//ankomsttider skumma?
			} break;
			case G.READY:{
				numberInQueue--;
				numberInQueue2++;
				//System.out.println("in q2: "+numberInQueue2);
				if(numberInQueue2 == 1){
					EventList.InsertEvent(G.READY2, G.time + 2);
				}
				if (numberInQueue > 0){
					EventList.InsertEvent(G.READY, G.time + (-2.1)*Math.log(1.0-slump.nextDouble()));
				}
			} break;
			case G.MEASURE:{
				accumulated = accumulated + numberInQueue;
				accumulated2 = accumulated2 + numberInQueue2;
				noMeasurements++;
				EventList.InsertEvent(G.MEASURE, G.time + (-5.0)*Math.log(1.0-slump.nextDouble()));
				W.println(String.valueOf(numberInQueue));
			} break;
			case G.READY2:{
				numberInQueue2--;
				if (numberInQueue2 > 0){
					EventList.InsertEvent(G.READY2, G.time + 2);
				}
			} break;
		}
	}
}