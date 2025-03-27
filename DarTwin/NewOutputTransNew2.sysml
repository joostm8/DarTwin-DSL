package NewOutputTrans2 {
	doc /* This the evolution from Basic to New Output (two actuators) 
	 *  It combines the Orthogonal and New Output transforms*/
	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	private import NewOutputTrans::*;
	
	
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
	
	
	#dartwin Orthogonal_core :> Basic;
	#dartwin Orthogonal_before :> Orthogonal_core; 
	
	#dartwin NewOutput2_core :> Basic;
	
	#dartwin NewOutput2_before :> NewOutput2_core;
	doc /* In this evolution there are only additions */

	// Now we see how NewOutputTransNew can apply to the following
	// We know that Orthogonal_afterw is equivalent to NewOutput_before
	#dartwin Orthogonal_afterw :> Orthogonal_core {
		#twinsystem :>> TwinSystem {
			#digitaltwin DT2 {
				port p21;
				port p22;
			}
			
			connection c4 connect Orthogonal_afterw.AT.ts1 to DT2.p21; 
			connection c5 connect DT2.p22 to Orthogonal_afterw.AT.ts2;
		}
		
		#goal Goal2 {
			doc /* Goal 2 */
		}			
		allocation a2 allocate Goal2 to TwinSystem.DT2;		
	}
	
	#dartwin NewOutput2_interim :> Orthogonal_core, NewOutput_before {
		doc /* NewOutput2_interim is equivalent to Orthogonal_before by also 
		 * inheriting NewOutput_before as a role marking scheme
		 */
		#twinsystem :>> NewOutput_before.TwinSystem {
			#digitaltwin :>> NewOutput_before.TwinSystem.DT2;
			
			connection :>> NewOutput_before.TwinSystem.c4 connect NewOutput2_interim.AT.ts1 to DT2.p21; // redef
			connection :>> NewOutput_before.TwinSystem.c5 connect DT2.p22 to NewOutput2_interim.AT.ts2; // redef
		}
		
		#goal :>> NewOutput_before.Goal2;			
		allocation :>> a2 allocate Goal2 to NewOutput_before.TwinSystem.DT2;		
	}
	
	// To get to NewOutput_afterw we need to inherit NewOutput_core first
	#dartwin NewOutput2_interim2 :> Orthogonal_core, NewOutput_core {
		doc /* NewOutput2_interim2 is less than Orthogonal_before by
		 * inheriting NewOutput_core as a role marking scheme
		 */
		#twinsystem :>> NewOutput_core.TwinSystem {
			#digitaltwin :>> NewOutput_core.TwinSystem.DT2;
			
			connection :>> NewOutput_core.TwinSystem.c4 connect NewOutput2_interim2.AT.ts1 to DT2.p21; // redef
			//connection :>> NewOutput_core.TwinSystem.c5 connect DT2.p22 to NewOutput2_interim2.AT.ts2; // not in _core
		}
		
		#goal :>> NewOutput_core.Goal2;			
		allocation :>> a2 allocate Goal2 to NewOutput_core.TwinSystem.DT2;		
	}
	
	// Now we may apply NewOutput_afterw on NewOutput2_interim2
	#dartwin NewOutput2_interim3 :> Orthogonal_core, NewOutput_afterw {
		doc /* NewOutput2_interim3 is the end of the evolution
		 * inheriting NewOutput_afterw 
		 */
		#twinsystem :>> NewOutput_afterw.TwinSystem {
			#digitaltwin :>> NewOutput_afterw.TwinSystem.DT2;
			
			connection :>> NewOutput_afterw.TwinSystem.c4 connect NewOutput2_interim2.AT.ts1 to DT2.p21; // redef
			//connection :>> NewOutput_core.TwinSystem.c5 connect DT2.p22 to NewOutput2_interim2.AT.ts2; // not in _core
		}
		
		#goal :>> NewOutput_afterw.Goal2;			
		allocation :>> a2 allocate Goal2 to NewOutput_afterw.TwinSystem.DT2;		
	}
	
	// Finally, we flatten NewOutput2_interim3 by copying the NewOutput_afterw
	#dartwin NewOutput2_afterw :> Basic {
		doc /* NewOutput2_afterw is the flattened finish of the evolution
		 * eliminating NewOutput_afterw inheritance
		 */
		#twinsystem :>> TwinSystem {
			#digitaltwin DT2 {
				port p21;
				port p22;
			}
			
			connection c4 connect NewOutput2_afterw.AT.ts1 to DT2.p21; 
			connection c5 connect DT2.p22 to NewOutput2_afterw.AT.ts4;
		}
		
		part :>>AT {
			port ts4;
		}
		
		#goal Goal2 {
			doc /* Goal 2 */
		}			
		allocation a2 allocate Goal2 to TwinSystem.DT2;				
	}
	
} // NewOutputTrans2 package
