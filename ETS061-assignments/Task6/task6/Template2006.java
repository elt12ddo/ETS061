package task6;

import java.util.*;
import java.io.*;

public class Template2006 {
 
    public static void main(String[] args) throws IOException {
    	double time = 0;
    	double averages = 0;
    	Event actEvent;
    	State actState = null;
    	for(int k = 0; k < 1000; k++){
    		actState = new State();
    		new EventList();
    		EventList.InsertEvent(G.ARRIVAL, 1);
    		EventList.InsertEvent(G.MEASURE, 5);
    		while (actState.numberInQueue != 0 || G.time <= 17){
    			actEvent = EventList.FetchEvent();
    			G.time = actEvent.eventTime;
    			actState.TreatEvent(actEvent);
    		}
    		time = G.time + time;
    		averages = averages + ((actState.readyTimes - actState.arrivalTimes) / actState.nbrOfArrivals);
    		//System.out.println((actState.readyTimes - actState.arrivalTimes) / actState.nbrOfArrivals);
    		//System.out.println((actState.readyTimes));
    		//System.out.println((actState.arrivalTimes));
    		G.time = 0;
    	}
    	System.out.println("Average closing time: " + time/1000);
    	System.out.println("Average time doing stuff: " + averages/1000);
    	
    	/*System.out.println("rej: "+ actState.nbrRejected);
    	System.out.println("P(Rejected): " + 1.0*actState.nbrRejected/actState.nbrOfArrivals);
    	System.out.println(actState.accumulated);
    	System.out.println(actState.noMeasurements);*/
    	actState.W.close();
    }
}