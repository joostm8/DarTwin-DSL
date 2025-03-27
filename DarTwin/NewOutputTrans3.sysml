package NewOutputTrans3_0 {
	doc /* This the start of evolution from Basic to New Output (two actuators) 
	 *  It combines the Orthogonal and New Output transforms*/
	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	private import BasicTrans::*;
	private import NewOutputTrans::*;

	// We will make 3 dartwins: _before, _core and _afterw (eventually)
	
	// _before is the starting point and identical to that of Orthogonal	
	#dartwin NewOutput3_before :> Basic;
	// Since neither Orthogonal, nor 		
		
	// 0. Copy the Orthogonal transformation result and rename
	#dartwin NewOutput3_afterw :> Basic {
		#twinsystem :>> TwinSystem {
			#digitaltwin DT2 {
				port p21;
				port p22;
			}
			
			connection c4 connect NewOutput3_afterw.AT.ts1 to DT2.p21; 
			connection c5 connect DT2.p22 to NewOutput3_afterw.AT.ts2;
		}
		
		#goal Goal2 {
			doc /* Goal 2 */
		}			
		allocation a2 allocate Goal2 to TwinSystem.DT2;		
	}
}


package NewOutputTrans3_1_2 {
	doc /* 1.+ 2 Mark by inheriting NewOutput_before */
	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	private import BasicTrans::*;
	private import NewOutputTrans::*;

	// We will make 3 dartwins: _before, _core and _afterw
	
	// _before is the starting point and identical to that of Orthogonal	
	#dartwin NewOutput3_before :> Basic;
		
	#dartwin NewOutput3_afterw :> NewOutput_before {
		#twinsystem :>> TwinSystem {
			#digitaltwin :>> TwinSystem.DT2 {
				port :>> p21;
				port :>> p22;
			}
			
			connection :>> c4 connect NewOutput_core.AT.ts1 to DT2.p21; 
			connection :>> c5 connect DT2.p22 to NewOutput_before.AT.ts2;
		}
		
		#goal :>> NewOutput_core.Goal2 {
			doc /* Goal 2 */
		}			
		allocation :>> a2 allocate Goal2 to NewOutput_core.TwinSystem.DT2;		
	}
}


package NewOutputTrans3_3 {
	doc /* 3. Continue by inheriting only from NewOutput_core */
	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	private import BasicTrans::*;
	private import NewOutputTrans::*;

	// We will make 3 dartwins: _before, _core and _afterw
	
	// _before is the starting point and identical to that of Orthogonal	
	#dartwin NewOutput3_before :> Basic;
		
	#dartwin NewOutput3_afterw :> NewOutput_core {
		#twinsystem :>> TwinSystem {
			#digitaltwin :>> TwinSystem.DT2 {
				port :>> p21;
				port :>> p22;
			}
			
			connection :>> c4 connect NewOutput_core.AT.ts1 to DT2.p21; 
			// DELETE: connection :>> c5 connect DT2.p22 to NewOutput_core.AT.ts2;
		}
		
		#goal :>> Goal2 {
			doc /* Goal 2 */
		}			
		allocation :>> a2 allocate Goal2 to TwinSystem.DT2;		
	}
}

package NewOutputTrans3_4 {
	doc /* 4. Continue by inheriting from NewOutput_afterw */
	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	private import BasicTrans::*;
	private import NewOutputTrans::*;

	// We will make 3 dartwins: _before, _core and _afterw
	
	// _before is the starting point and identical to that of Orthogonal	
	#dartwin NewOutput3_before :> Basic;
		
	#dartwin NewOutput3_afterw :> NewOutput_afterw {
		#twinsystem :>> TwinSystem {
			#digitaltwin :>> TwinSystem.DT2 {
				port :>> p21;
				port :>> p22;
			}
			
			connection :>> c4 connect NewOutput_core.AT.ts1 to DT2.p21; 
			// DELETE: connection :>> TwinSystem.c5 connect DT2.p22 to NewOutput_core.AT.ts2;
			connection :>> c5 connect DT2.p22 to NewOutput_afterw.AT.ts4;
		}
		
		part :>> NewOutput_afterw.AT {
			port :>>ts4;
		}
		
		#goal :>> NewOutput_core.Goal2 {
			doc /* Goal 2 */
		}			
		allocation :>> a2 allocate Goal2 to NewOutput_core.TwinSystem.DT2;		
	}
}

package NewOutputTrans3 {
	doc /* 5. Flatten by copying NewOutput_afterw into NewOutput3_afterw
	 *  All the special elements in NewOutput_afterw have been redefined,
	 *  and what is in addition from the NewOutput_core is actually Basic
	 */
	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	private import BasicTrans::*;

	// We will make 3 dartwins: _before, _core and _afterw
	
	// _before is the starting point and identical to that of Orthogonal	
	#dartwin NewOutput3_before :> Basic;
		
	#dartwin NewOutput3_afterw :> Basic {
		#twinsystem :>> TwinSystem {
			#digitaltwin DT2 {
				port p21;
				port p22;
			}
			
			connection c4 connect NewOutput3_afterw.AT.ts1 to DT2.p21; 
			// DELETE: connection :>> TwinSystem.c5 connect DT2.p22 to NewOutput_core.AT.ts2;
			connection c5 connect DT2.p22 to NewOutput3_afterw.AT.ts4;
		}
		
		part :>> AT {
			port ts4;
		}
		
		#goal Goal2 {
			doc /* Goal 2 */
		}			
		allocation a2 allocate Goal2 to TwinSystem.DT2;		
	}
	
	
	// We can now easily see that 
	#dartwin NewOutput3_core :> Basic;
}