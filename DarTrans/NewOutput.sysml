package NewOutputTrans {
	doc /* The NewOutput from original DarTwin paper */
	private import ScalarValues::*;
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	
	#dartrans NewOutput {
		#dartwin_core NewOutput_core {
			doc /* This will be smaller than Orthogonal 
			 * since something will be deleted/changed
			 */
			#twinsystem TwinSystem {
				#digitaltwin DT1 {			
					port p11;
					port p12;
					port p13;
				}			
				connection c1 connect NewOutput.NewOutput_core.AT.ts1 to DT1.p11;			
				connection c2 connect NewOutput.NewOutput_core.AT.ts2 to DT1.p12;
				connection c3 connect DT1.p13 to NewOutput.NewOutput_core.AT.ts3;
							
				#digitaltwin DT2 {
					port p21;
					port p22;
				}
				
				connection c4 connect NewOutput.NewOutput_core.AT.ts1 to DT2.p21; 
				// DELETED: connection c5 connect DT2.p22 to NewOutput.NewOutput_core.AT.ts2;
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
		
		#dartwin_before NewOutput_before :> NewOutput_core {
			doc /* NewOutput_before is equivalent to Orthogonal */
			
			#twinsystem :>> TwinSystem {
				connection c5 connect DT2.p22 to NewOutput.NewOutput_before.AT.ts2;
			}
		}
		
		#dartwin_after NewOutput_afterw :> NewOutput_core {
			doc /* NewOutput_afterw is the evolution result */
			
			#twinsystem :>> TwinSystem {
				connection c5 connect DT2.p22 to NewOutput.NewOutput_afterw.AT.ts4;
			}
			
			part :>>AT {
				port ts4;
			}
		}
		
	}
}