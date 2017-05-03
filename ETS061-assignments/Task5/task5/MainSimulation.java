package task5;

import java.util.*;
import java.io.*;

//Denna klass ärver Global så att man kan använda time och signalnamnen utan punktnotation
//It inherits Proc so that we can use time and the signal names without dot notation


public class MainSimulation extends Global{

    public static void main(String[] args) throws IOException {

    	//Signallistan startas och actSignal deklareras. actSignal är den senast utplockade signalen i huvudloopen nedan.
    	// The signal list is started and actSignal is declaree. actSignal is the latest signal that has been fetched from the 
    	// signal list in the main loop below.

    	Signal actSignal;
    	new SignalList();

    	//Här nedan skapas de processinstanser som behövs och parametrar i dem ges värden.
    	// Here process instances are created (two queues and one generator) and their parameters are given values. 

    	QS Q1 = new QS();
    	QS Q2 = new QS();
    	QS Q3 = new QS();
    	QS Q4 = new QS();
    	QS Q5 = new QS();
    	Q1.sendTo = null;
    	Q2.sendTo = null;
    	Q3.sendTo = null;
    	Q4.sendTo = null;
    	Q5.sendTo = null;
    	Dispatcher3 D = new Dispatcher3(Q1,Q2,Q3,Q4,Q5); 
    	Gen Generator = new Gen();
    	//Generator.lambda = 1/0.11; //Generator ska generera nio kunder per sekund  //Generator shall generate 9 customers per second
    	Generator.sendTo = D; //De genererade kunderna ska skickas till kösystemet QS  // The generated customers shall be sent to Q1

    	//Här nedan skickas de första signalerna för att simuleringen ska komma igång.
    	//To start the simulation the first signals are put in the signal list

    	SignalList.SendSignal(READY, Generator, time);
    	SignalList.SendSignal(MEASURE, Q1, time);
    	SignalList.SendSignal(MEASURE, Q2, time);
    	SignalList.SendSignal(MEASURE, Q3, time);
    	SignalList.SendSignal(MEASURE, Q4, time);
    	SignalList.SendSignal(MEASURE, Q5, time);


    	// Detta är simuleringsloopen:
    	// This is the main loop

    	while (time < 100000){
    		actSignal = SignalList.FetchSignal();
    		time = actSignal.arrivalTime;
    		actSignal.destination.TreatSignal(actSignal);
    	}

    	//Slutligen skrivs resultatet av simuleringen ut nedan:
    	//Finally the result of the simulation is printed below:
    	System.out.println("Mean number of customers in Q1: " + 1.0*Q1.accumulated/Q1.noMeasurements);
    	System.out.println("Mean number of customers in Q2: " + 1.0*Q2.accumulated/Q2.noMeasurements);
    	System.out.println("Mean number of customers in Q3: " + 1.0*Q3.accumulated/Q3.noMeasurements);
    	System.out.println("Mean number of customers in Q4: " + 1.0*Q4.accumulated/Q4.noMeasurements);
    	System.out.println("Mean number of customers in Q5: " + 1.0*Q5.accumulated/Q5.noMeasurements);

    }
}