package ArbiterTrans {
	doc /* This the arbiter evolution */
	private import ScalarValues::*;
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	
	
	#dartwin arbiter_core  {
	
		#twinsystem TwinSystem {
		
			#digitaltwin DT1 {			
				port p11;
				port p12;
			}	
			
			#digitaltwin DT2 {
				port p21;
				port p22;
			}	
				
			connection c1 connect arbiter_core.AT.ts1 to DT1.p11;
			connection c2 connect arbiter_core.AT.ts1 to DT2.p21;			
						
		} // TwinSystem		
		
		part AT {
			port ts1;
			port ts2;
		}
		
		#goal Goal1{
			doc /* Goal 1 */
		}						
		allocation a1 allocate Goal1 to TwinSystem.DT1;
		
		#goal Goal2 {
			doc /* Goal 2 */
		}
		allocation a2 allocate Goal2 to TwinSystem.DT2;	
	
	} // arbiter_core
	
	#dartwin arbiter_before :> arbiter_core;
	doc /* In this evolution there are only additions */
	
	#dartwin arbiter_afterw :> arbiter_core {
		#twinsystem :>> TwinSystem {
			#arbiter Arbiter{
				port i1 :> inputs;
				port i2 :> inputs;
				port o3 :> output;
			}
			
			connection c3 connect DT1.p12 to Arbiter.i1;
			connection c4 connect DT2.p22 to Arbiter.i2;
			connection c5 connect Arbiter.o3 to arbiter_afterw.AT.ts2;
		}
	}
} // ArbiterTrans package
