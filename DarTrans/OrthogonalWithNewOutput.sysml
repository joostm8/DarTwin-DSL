package OrthogonalWithNewOutputTrans {
	doc /* The NewOutput from original DarTwin paper */
	private import ScalarValues::*;
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	private import BasicTrans::*;
	
	#dartrans OrthogonalWithNewOutput {
		#dartwin_core OrthogonalWithNewOutput_core :> Basic;		
		#dartwin_before OrthogonalWithNewOutput_before :> OrthogonalWithNewOutput_core;
			
		#dartwin_after OrthogonalWithNewOutput_after :> Basic {
			#twinsystem :>> TwinSystem {
				#digitaltwin DT2 {
					port p21;
					port p22;
				}
				
				connection c4 connect OrthogonalWithNewOutput.OrthogonalWithNewOutput_after.AT.ts1 to DT2.p21; 
				connection c5 connect DT2.p22 to OrthogonalWithNewOutput.OrthogonalWithNewOutput_after.AT.ts4;
			}
			
			part :>> AT {
				port ts4;
			}
			
			#goal Goal2 {
				doc /* Goal 2 */
			}			
			allocation a2 allocate Goal2 to TwinSystem.DT2;		
		}
				
	}	
}