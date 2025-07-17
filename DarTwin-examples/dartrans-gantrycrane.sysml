package DarTransExample{
private import DarTwin::*;
private import DarTwinMetadata::*;
private import Replacement::*;
	
package Step_1{
	doc /* base system */
	
	#dartwin OptimalControl {
		#twinsystem GantryCrane {
			#digitaltwin TrajectoryLQR{
				port sense;
				port actuate;
			}
		}
		part PhysCrane{
			port actuate;
			port sense;
		}
		
		#goal NoSwing;
		
		connection actuation connect GantryCrane.TrajectoryLQR.actuate to PhysCrane.actuate;
		connection sensing connect PhysCrane.actuate to GantryCrane.TrajectoryLQR.sense;
		
		allocation noSwinging allocate NoSwing to GantryCrane.TrajectoryLQR;
	}	
}

package Step_2{
	doc /* Step 2: select pattern Replacement, inherit from its before */
	
	#dartwin OptimalControl :> Replacement.dt_before{
		#twinsystem GantryCrane :> Replacement.dt_before.TS{
			#digitaltwin TrajectoryLQR :> DT1{
				port sense :> p1;
				port actuate :> p2;
			}
		}
		
		part PhysCrane :> Replacement.dt_before.AT{
			port actuate :> p1;
			port sense :> p2;
		}
		
		#goal NoSwing :> Replacement.dt_before.goal1;
		
		connection actuation :> Replacement.dt_before.c1 connect GantryCrane.TrajectoryLQR.actuate to PhysCrane.actuate;
		connection sensing :> Replacement.dt_before.c2 connect PhysCrane.actuate to GantryCrane.TrajectoryLQR.sense;
		
		allocation noSwinging :> Replacement.dt_before.a1 allocate noSwinging to GantryCrane.TrajectoryLQR;
	}
}

package Step_3{
	doc /* Steps 3: deletions by going from before to core */

	#dartwin exampleSystem :> Replacement.dt_core{
		
		part PhysCrane :> AT{
			port actuate :> p1;
			port sense :> p2;
		}
		
		#goal NoSwing :> Replacement.dt_core.goal1;	
	}
}

package Step_4{
	doc /* Step 4: make additions inheriting from afterw */
	
	#dartwin OptimalControl :> Replacement.dt_after {
	#twinsystem GantryCrane :> Replacement.dt_after.TS{
		#digitaltwin TrajectoryOCP :> DT2{
			port sense :> p1;
			port actuate :> p2; 
		}
	}
	part PhysCrane :> Replacement.dt_after.AT{
		port actuate :> p1;
		port sense :> p2;
	}
	
	#goal NoSwing :> Replacement.dt_after.goal1;
	
	connection actuation :> Replacement.dt_after.c1 connect GantryCrane.TrajectoryOCP.actuate to PhysCrane.actuate;
	connection sensing :> Replacement.dt_after.c2 connect PhysCrane.actuate to GantryCrane.TrajectoryOCP.sense;
	
	allocation noSwinging :> Replacement.dt_after.a1 allocate NoSwing to GantryCrane.TrajectoryOCP;
	}	
	
}

package Step_5{
	doc /* Step 5: flatten -> remove references to transformation */
	
	#dartwin OptimalControl {
	#twinsystem GantryCrane {
		#digitaltwin TrajectoryOCP{
			port sense;
			port actuate;
		}
	}
	part PhysCrane{
		port actuate;
		port sense;
	}
	
	#goal NoSwing;
	
	connection actuation connect GantryCrane.TrajectoryOCP.actuate to PhysCrane.actuate;
	connection sensing connect PhysCrane.actuate to GantryCrane.TrajectoryOCP.sense;
	
	allocation noSwinging allocate NoSwing to GantryCrane.TrajectoryOCP;
	}	
}
}

