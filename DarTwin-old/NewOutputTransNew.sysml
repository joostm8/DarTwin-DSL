package NewOutputTrans {
	doc /* This the new output evolution */
	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
		
	#dartwin Orthogonal {
		doc /* The flattened version of Orthogonal where this starts */
		
		#twinsystem TwinSystem {
			#digitaltwin DT1 {			
				port p11;
				port p12;
				port p13;
			}			
			connection c1 connect Orthogonal.AT.ts1 to DT1.p11;			
			connection c2 connect Orthogonal.AT.ts2 to DT1.p12;
			connection c3 connect DT1.p13 to Orthogonal.AT.ts3;
						
			#digitaltwin DT2 {
				port p21;
				port p22;
			}
			
			connection c4 connect Orthogonal.AT.ts1 to DT2.p21; 
			connection c5 connect DT2.p22 to Orthogonal.AT.ts2;
		}
		part AT {
			port ts1;
			port ts2;
			port ts3;
		}
		
		#goal Goal1{
			doc /* Goal 1 */
		}						
		allocation a1 allocate Goal1 to TwinSystem.DT1;
		
		#goal Goal2 {
			doc /* Goal 2 */
		}			
		allocation a2 allocate Goal2 to TwinSystem.DT2;				
	}
	
	#dartwin NewOutput_core {
		doc /* This will be smaller than Orthogonal 
		 * since something will be deleted/changed
		 */
		#twinsystem TwinSystem {
			#digitaltwin DT1 {			
				port p11;
				port p12;
				port p13;
			}			
			connection c1 connect NewOutput_core.AT.ts1 to DT1.p11;			
			connection c2 connect NewOutput_core.AT.ts2 to DT1.p12;
			connection c3 connect DT1.p13 to NewOutput_core.AT.ts3;
						
			#digitaltwin DT2 {
				port p21;
				port p22;
			}
			
			connection c4 connect NewOutput_core.AT.ts1 to DT2.p21; 
			// DELETED: connection c5 connect DT2.p22 to NewOutput_core.AT.ts2;
		}
		part AT {
			port ts1;
			port ts2;
			port ts3;
		}
		
		#goal Goal1{
			doc /* Goal 1 */
		}						
		allocation a1 allocate Goal1 to TwinSystem.DT1;
		
		#goal Goal2 {
			doc /* Goal 2 */
		}			
		allocation a2 allocate Goal2 to TwinSystem.DT2;				
	}
	
	#dartwin NewOutput_before :> NewOutput_core {
		doc /* NewOutput_before is equivalent to Orthogonal */
		
		#twinsystem :>> TwinSystem {
			connection c5 connect DT2.p22 to NewOutput_before.AT.ts2;
		}
	}
	
	#dartwin NewOutput_afterw :> NewOutput_core {
		doc /* NewOutput_afterw is the evolution result */
		
		#twinsystem :>> TwinSystem {
			connection c5 connect DT2.p22 to NewOutput_afterw.AT.ts4;
		}
		
		part :>>AT {
			port ts4;
		}
	}
	
	#dartwin NewOutput {
		doc /* This is the flattened NewOutput_afterw */
		#twinsystem TwinSystem {
			#digitaltwin DT1 {			
				port p11;
				port p12;
				port p13;
			}			
			connection c1 connect NewOutput.AT.ts1 to DT1.p11;			
			connection c2 connect NewOutput.AT.ts2 to DT1.p12;
			connection c3 connect DT1.p13 to NewOutput.AT.ts3;
						
			#digitaltwin DT2 {
				port p21;
				port p22;
			}
			
			connection c4 connect NewOutput.AT.ts1 to DT2.p21; 
			connection c5 connect DT2.p22 to NewOutput.AT.ts4; // NEW
		}
		part AT {
			port ts1;
			port ts2;
			port ts3;
			port ts4; // NEW
		}
		
		#goal Goal1{
			doc /* Goal 1 */
		}						
		allocation a1 allocate Goal1 to TwinSystem.DT1;
		
		#goal Goal2 {
			doc /* Goal 2 */
		}			
		allocation a2 allocate Goal2 to TwinSystem.DT2;				
	}
	
	
} // NewOutputTrans package
