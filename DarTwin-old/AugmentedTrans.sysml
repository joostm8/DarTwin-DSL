package AugmentedTrans {
	doc /* This the augmented evolution */
	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	
	
	#dartwin augmented_core  {
	
		#twinsystem TwinSystem {
		
			#digitaltwin DT1 {			
				port p11;
				port p12;
				port p13;
			}	
				
			connection c2 connect augmented_core.AT.ts2 to DT1.p12;		
			connection c3 connect DT1.p13 to augmented_core.AT.ts3;			
				
						
		} // TwinSystem		
		
		part AT {
			port ts2;
			port ts3;
		}
		
		#goal Goal1{
			doc /* Goal 1 */
		}						
		allocation a1 allocate Goal1 to TwinSystem.DT1;
	
	} // augmented_core
	
	#dartwin augmented_before :> augmented_core;
	doc /* In this evolution there are only additions */
	
	#dartwin augmented_afterw :> augmented_core {
		#twinsystem :>> TwinSystem {
			#digitaltwin DT2 {
				port p21;
				port p22;
				port p23;
			}		
			
			connection c4 connect augmented_afterw.AT.ts1 to DT2.p21;
			connection c5 connect augmented_afterw.AT.ts4 to DT2.p22;
			connection c6 connect DT2.p23 to DT1.p11;
		}
		
		part :>>AT {
			port ts1;
			port ts4;
		}
		
		#goal Goal2 {
			doc /* Goal 2 */
		}
		allocation a2 allocate Goal2 to TwinSystem.DT2;
	}
} // AugmentedTrans package
