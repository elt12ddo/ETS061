package task2;

import java.util.*;
import java.io.*;

class State{
	public int numberInQueueA = 0, numberInQueueB = 0, accumulated = 0, noMeasurements = 0;

	Random slump = new Random();
	SimpleFileWriter W = new SimpleFileWriter("./Task2/number.m", false);
	
	public void TreatEvent(Event x){
		switch (x.eventType){
			case G.ARRIVAL_A:{
				numberInQueueA++;
				if(numberInQueueA + numberInQueueB == 1){
					EventList.InsertEvent(G.READY_A, G.time + 0.002);
				}
				EventList.InsertEvent(G.ARRIVAL_A, G.time - (1/150.0)*Math.log(1.0-slump.nextDouble()));
			} break;
			case G.ARRIVAL_B:{
				numberInQueueB++;
				if(numberInQueueA + numberInQueueB == 1){
					EventList.InsertEvent(G.READY_B, G.time + 0.004);
				}
			} break;
			case G.READY_A:{
				numberInQueueA--;
				//readyHandler(true);//a
				readyHandler(false);//c
				EventList.InsertEvent(G.ARRIVAL_B, G.time + 1);//a
				//EventList.InsertEvent(G.ARRIVAL_B, G.time - (1.0)*Math.log(1.0-slump.nextDouble()));//b
			} break;
			case G.READY_B:{
				numberInQueueB--;
				//readyHandler(true);//a
				readyHandler(false);//c
			} break;
			case G.MEASURE:{
				accumulated = accumulated + numberInQueueA + numberInQueueB;
				noMeasurements++;
				EventList.InsertEvent(G.MEASURE, G.time + 0.1);
				W.println(String.valueOf(numberInQueueA+numberInQueueB));
			} break;
		}
	}
	private void readyHandler(boolean bFirst){
		if(bFirst){
			if(numberInQueueB > 0){
				EventList.InsertEvent(G.READY_B, G.time + 0.004);
			} else if(numberInQueueA > 0){
				EventList.InsertEvent(G.READY_A, G.time + 0.002);
			}
		} else {
			if(numberInQueueA > 0){
				EventList.InsertEvent(G.READY_A, G.time + 0.002);
			} else if(numberInQueueB > 0){
				EventList.InsertEvent(G.READY_B, G.time + 0.004);
			}
		}
	}
}