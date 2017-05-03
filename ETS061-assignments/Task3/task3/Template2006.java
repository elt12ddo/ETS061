package task3;

import java.util.*;
import java.io.*;

public class Template2006 {
 
    public static void main(String[] args) throws IOException {
    	Event actEvent;
    	State actState = new State();
    	new EventList();
        EventList.InsertEvent(G.ARRIVAL, 1);
        EventList.InsertEvent(G.MEASURE, 5);
    	while (actState.noMeasurements < 1000){
    		actEvent = EventList.FetchEvent();
    		G.time = actEvent.eventTime;
    		actState.TreatEvent(actEvent);
    	}
    	double acc = 0.0;
    	for(int i = 0; i < actState.stop.size(); i++){
    		acc = acc + actState.stop.get(i) - actState.start.get(i);
    	}
    	System.out.println("Mean nbr of customers in system: " + 1.0*(actState.accumulated2 + actState.accumulated)/actState.noMeasurements);
    	System.out.println("HELLO WORLD: " + acc / actState.stop.size());
    	actState.W.close();
    }
}