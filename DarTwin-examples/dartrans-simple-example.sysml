package DarTransExampleStep_1{
	doc /* base system */
	
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	private import Replacement::*;
	
	#dartwin exampleSystem {
		#twinsystem TS {
			#digitaltwin DT1{
				port p1;
				port p2;
			}
		}
		part AT{
			port p1;
			port p2;
		}
		
		#goal Goal1;
		
		connection c1 connect TS.DT1.p1 to AT.p1;
		connection c2 connect TS.DT1.p2 to AT.p2;
		
		allocation a1 allocate Goal1 to TS.DT1;
	}	
}

package DarTransExampleStep_2{
	doc /* Step 2: select pattern Replacement, inherit from its before */
	
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	private import Replacement::*;
	
		#dartwin exampleSystem :> Replacement.dt_before{
			#twinsystem TS :> Replacement.dt_before.TS{
				#digitaltwin DT1 :> Replacement.dt_before.TS.DT1{
					port p1 :> Replacement.dt_before.TS.DT1.p2;
					port p2 :> Replacement.dt_before.TS.DT1.p2;
				}
			}
			
			part AT :> Replacement.dt_before.AT{
				port p1 :> Replacement.dt_before.AT.p1;
				port p2 :> Replacement.dt_before.AT.p2;
			}
			
			#goal goal1 :> Replacement.dt_before.goal1;
			
			connection c1 :> Replacement.dt_before.c1 connect TS.DT1.p1 to AT.p1; // doesn't inheriting the connection allready make it?'
			connection c2 :> Replacement.dt_before.c2 connect TS.DT1.p2 to AT.p2;
			
			allocation a1 :> Replacement.dt_before.a1 allocate goal1 to TS.DT1;
	}
}

package DarTransExampleStep_3{
	
	doc /* Steps 3: deletions by going from before to core */
	
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	private import Replacement::*;
	
		#dartwin exampleSystem :> Replacement.dt_core{
			
			part AT :> Replacement.dt_core.AT{
				port p1 :> Replacement.dt_core.AT.p1;
				port p2 :> Replacement.dt_core.AT.p2;
			}
			
			#goal goal1 :> Replacement.dt_core.goal1;	
	}
}

package DarTransExampleStep_4{
	doc /* Step 4: make additions inheriting from afterw */
	
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	private import Replacement::*;
	
		#dartwin exampleSystem :> Replacement.dt_after{
			#twinsystem TS :> Replacement.dt_after.TS{
				#digitaltwin DT2 :> Replacement.dt_after.TS.DT2{
					port p1 :> Replacement.dt_after.TS.DT2.p2;
					port p2 :> Replacement.dt_after.TS.DT2.p2;
				}
			}
			
			part AT :> Replacement.dt_after.AT{
				port p1 :> Replacement.dt_after.AT.p1;
				port p2 :> Replacement.dt_after.AT.p2;
			}
			
			#goal goal1 :> Replacement.dt_after.goal1;
			
			connection c1 :> Replacement.dt_after.c1 connect TS.DT2.p1 to AT.p1; // doesn't inheriting the connection allready make it?'
			connection c2 :> Replacement.dt_after.c2 connect TS.DT2.p2 to AT.p2;
			
			allocation a1 :> Replacement.dt_after.a1 allocate goal1 to TS.DT2;
	}
	
}

package DarTransExampleStep_5{
	doc /* Step 5: flatten -> remove references to transformation */
	
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	private import Replacement::*;
	
		#dartwin exampleSystem{
			#twinsystem TS{
				#digitaltwin DT2{
					port p1;
					port p2;
				}
			}
			
			part AT{
				port p1;
				port p2;
			}
			
			#goal goal1;
			
			connection c1 connect TS.DT2.p1 to AT.p1; // doesn't inheriting the connection allready make it?'
			connection c2 connect TS.DT2.p2 to AT.p2;
			
			allocation a1 allocate goal1 to TS.DT2;
	}
	
}

