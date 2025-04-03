package BasicTrans {
	doc /* This the Basic DarTwin */
	private import ScalarValues::*;
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	
	
	#dartwin Basic  {
	
		#twinsystem TwinSystem {
		
			#digitaltwin DT1 {			
				port p11;
				port p12;
				port p13;
			}			
			connection c1 connect Basic.AT.ts1 to DT1.p11;			
			connection c2 connect Basic.AT.ts2 to DT1.p12;
			connection c3 connect DT1.p13 to Basic.AT.ts3;
						
		} // TwinSystem		
		
		part AT {
			port ts1;
			port ts2;
			port ts3;
		}
		
		#goal Goal1{
			doc /* Goal 1 */
		}						
		allocation a1 allocate Goal1 to TwinSystem.DT1;
	
	} // Basic DarTwin
	
} // BasicTrans package
