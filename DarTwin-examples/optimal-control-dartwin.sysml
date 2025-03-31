package OptimalControBase {
	doc /* Initial Gantry Crane system  */

	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	
	#dartwin OptimalControl {
		
		#twinsystem GantryCrane {
			
			#digitaltwin GantryCrane {
				port p1;
				port p2;
				port p3;
			}
			
			connect OptimalControl.AT.MotorPosition to GantryCrane.p1;
			connect OptimalControl.AT.SwingAngle to GantryCrane.p2;
			connect OptimalControl.AT.MotorControllers to GantryCrane.p3;
		}
		
		part AT {
			port MotorPosition;
			port SwingAngle;
			port MotorControllers;
		}
		
		# goal no_swinging_motion{
			doc /* No Swinging Motion */
			attribute angle:Real;
			attribute angle_at_t_end:Real;
			constraint def_no_swinging_motion {angle_at_t_end == 0}	
		}
		
		# goal respect_system_constraints{
			doc /* Respect System Constraints */
			attribute trace:Real; // how do you do list of reals?
			attribute violation_counter:Integer;
			constraint def_no_violations {violation_counter == 0}
		}
		
		# goal minimize_trajectory_duration {
			doc /* Minimize Trajectory Duration */
			attribute duration:Real;
			attribute t_min:Real;
			constraint def_minimize_duration {duration == t_min} // how to tell this should be minimized?
		}
		
		allocate no_swinging_motion to GantryCrane;
		allocate respect_system_constraints to GantryCrane;
		allocate minimize_trajectory_duration to GantryCrane;
		
		// for later revisions: the VS is clear, I had added the (union) and (strictest/minimal) to those lines
		// does that carry over?
		
	}
}