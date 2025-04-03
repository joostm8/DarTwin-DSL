package OrthogonalTrans {
	doc /* The NewOutput from original DarTwin paper */
	private import ScalarValues::*;
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	private import BasicTrans::*;
	
	#dartrans Orthogonal {
		#dartwin_core Orthogonal_core :> Basic;
		
		#dartwin_before Orthogonal_before :> Orthogonal_core;
		doc /* In this evolution there are only additions */
		
		#dartwin_after Orthogonal_after :> Orthogonal_core {
			#twinsystem :>> TwinSystem {
				#digitaltwin DT2 {
					port p21;
					port p22;
				}
				
				connection c4 connect Orthogonal.Orthogonal_after.AT.ts1 to DT2.p21; 
				connection c5 connect DT2.p22 to Orthogonal.Orthogonal_after.AT.ts2;
			}
			
			#goal Goal2 {
				doc /* Goal 2 */
			}			
			allocation a2 allocate Goal2 to TwinSystem.DT2;		
		}
		
	}
	
}