package task7;

class State{
	public int fails = 0;
	
	public void TreatEvent(Event x){
		switch (x.eventType){
			case G.FAIL1:{
				fails++;
			} break;
			case G.FAIL2:{
				fails++;
			} break;
		}
	}
}