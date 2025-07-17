package Replacement {
	
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	
	#dartrans Replacement{
		#dartwin_core dt_core{
			part AT {
				port p1;
				port p2;
			}
			
			#goal goal1;
		}
		
		#dartwin_before dt_before :> dt_core{
			#twinsystem TS{
				#digitaltwin DT1{
					port p1;
					port p2;
				} 
			}
			connection c1 connect TS.DT1.p1 to AT.p1;
			connection c2 connect AT.p2 to TS.DT1.p2;
			
			allocation a1 allocate goal1 to TS.DT1;
		} 
		
		#dartwin_after dt_after :> dt_core{
			#twinsystem TS{
				#digitaltwin DT2{
					port p1;
					port p2;
				} 
			}
			connection c1 connect TS.DT2.p1 to AT.p1;
			connection c2 connect AT.p2 to TS.DT2.p2;	
					
			allocation a1 allocate goal1 to TS.DT2;
			
		}
			
	}

}