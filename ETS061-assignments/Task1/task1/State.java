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
					nbrRejected++;
				}else{
					numberInQueue++;
					//System.out.println(numberInQueue);
				}
				if (numberInQueue == 1){
					EventList.InsertEvent(G.READY, G.time - (1/2.1)*Math.log(slump.nextDouble()));
				}
				EventList.InsertEvent(G.ARRIVAL, G.time + 1);
			} break;
			case G.READY:{
				numberInQueue--;
				numberInQueue2++;
				if(numberInQueue2 == 1){
					EventList.InsertEvent(G.READY2, G.time + 2);
				}
				if (numberInQueue > 0){
					EventList.InsertEvent(G.READY, G.time - (1/2.1)*Math.log(slump.nextDouble()));
				}
			} break;
			case G.MEASURE:{
				accumulated = accumulated + numberInQueue;
				accumulated2 = accumulated2 + numberInQueue2;
				noMeasurements++;
				EventList.InsertEvent(G.MEASURE, G.time - (1/5.0)*Math.log(slump.nextDouble()));
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