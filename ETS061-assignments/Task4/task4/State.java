package task4;

import java.util.*;
import java.io.*;

class State{
	public int numberInUse = 0, accumulated = 0, noMeasurements = 0, nbrRejected = 0, nbrOfArrivals = 0;
	

	Random slump = new Random();
	SimpleFileWriter W = new SimpleFileWriter("./Task4/number.m", false);
	
	public void TreatEvent(Event x){
		switch (x.eventType){
			case G.ARRIVAL:{
				nbrOfArrivals++;
				if(numberInUse >= 100){//N
					nbrRejected++;
				}else{
					numberInUse++;
					EventList.InsertEvent(G.READY, G.time + 10);//x
				}
				EventList.InsertEvent(G.ARRIVAL, G.time - (1/4.0)*Math.log(slump.nextDouble()));//Lambda
			} break;
			case G.READY:{
				numberInUse--;
			} break;
			case G.MEASURE:{
				accumulated = accumulated + numberInUse;
				noMeasurements++;
				EventList.InsertEvent(G.MEASURE, G.time + 4);//T
				W.println(String.valueOf(numberInUse));
			} break;
		}
	}
}