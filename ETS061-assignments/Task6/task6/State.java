package task6;

import java.util.*;
import java.io.*;

class State{
	public int numberInQueue = 0, accumulated = 0, noMeasurements = 0, nbrRejected = 0, nbrOfArrivals = 0;
	public double arrivalTimes = 0, readyTimes = 0;
	

	Random slump = new Random();
	SimpleFileWriter W = new SimpleFileWriter("./Task6/number.m", false);
	
	public void TreatEvent(Event x){
		switch (x.eventType){
			case G.ARRIVAL:{
				if(9 < x.eventTime && x.eventTime < 17){
					nbrOfArrivals++;
					numberInQueue++;
					arrivalTimes = arrivalTimes + G.time;
					if (numberInQueue == 1){
						double temp = G.time + ((10.0 + slump.nextDouble()*10.0)/60.0);
						EventList.InsertEvent(G.READY, temp);
						readyTimes = readyTimes + temp;
						}
					}
				EventList.InsertEvent(G.ARRIVAL, G.time - (1/4.0)*Math.log(slump.nextDouble()));
			} break;
			case G.READY:{
				numberInQueue--;
				if (numberInQueue > 0){
					double temp2 = G.time + ((10.0 + slump.nextDouble()*10.0)/60.0);
					EventList.InsertEvent(G.READY, temp2);
					readyTimes = readyTimes + temp2;
				}
			} break;
			case G.MEASURE:{
				accumulated = accumulated + numberInQueue;
				noMeasurements++;
				EventList.InsertEvent(G.MEASURE, G.time - (1/5.0)*Math.log(slump.nextDouble()));
				W.println(String.valueOf(numberInQueue));
			} break;
		}
	}
}