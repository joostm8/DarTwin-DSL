package OrthogonalTrans {
	doc /* This the orthongal evolution */
	private import ScalarValues::*;
	private import DarTwin1::*;
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
	
	#dartwin Orthogonal_core :> Basic;
	
	#dartwin Orthogonal_before :> Orthogonal_core;
	doc /* In this evolution there are only additions */
	
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
	
	#dartwin Orthogonal {
		doc /* The flattened version of Orthogonal_afterw */
		
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
	
} // OrthogonalTrans package
