package task7;

import java.util.*;
import java.io.*;

public class Template2006 {
	static Random slump = new Random();
 
    public static void main(String[] args) throws IOException {
    	double acc = 0.0;
    	Event actEvent;
    	for(int k = 0; k < 1000; k++){
    		State actState = new State();
    		new EventList();
    		EventList.InsertEvent(G.FAIL1, (slump.nextDouble()*4.0) + 1.0);
    		EventList.InsertEvent(G.FAIL2, (slump.nextDouble()*4.0) + 1.0);
    		while (actState.fails < 2){
    			actEvent = EventList.FetchEvent();
    			G.time = actEvent.eventTime;
    			actState.TreatEvent(actEvent);
    		}
    		acc = acc + G.time;
    	}
    	System.out.println("Average time to breakdown: " + acc/1000.0);
    }
}