package task2;

import java.util.*;
import java.io.*;

public class Template2006 {
 
    public static void main(String[] args) throws IOException {
    	Event actEvent;
    	State actState = new State();
    	new EventList();
        EventList.InsertEvent(G.ARRIVAL_A, 1);
        EventList.InsertEvent(G.MEASURE, 5);
    	while (actState.noMeasurements < 1000){
    		actEvent = EventList.FetchEvent();
    		G.time = actEvent.eventTime;
    		actState.TreatEvent(actEvent);
    	}
    	//System.out.println("rej: "+ actState.nbrRejected);
    	//System.out.println("P(Rejected): " + 1.0*actState.nbrRejected/actState.nbrOfArrivals);
    	System.out.println("Mean nbr of customers in buffer: " + 1.0*actState.accumulated/actState.noMeasurements);
    	System.out.println(actState.accumulated);
    	System.out.println(actState.noMeasurements);
    	actState.W.close();
    }
}