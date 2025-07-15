package OptimalControBase {
	doc /* Initial Gantry Crane system  */

	private import ScalarValues::*;
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	
	#dartwin OptimalControl {
		
		#twinsystem GantryCrane {
			
			#digitaltwin Trajectory {
				port p1;
				port p2;
				port p3;
			}
			
			connect OptimalControl.AT.MotorPosition to Trajectory.p1;
			connect OptimalControl.AT.SwingAngle to Trajectory.p2;
			connect OptimalControl.AT.MotorControllers to Trajectory.p3;
		}
		
		part AT {
			port MotorPosition;
			port SwingAngle;
			port MotorControllers;
		}
		
		# goal no_swinging_motion{
			attribute angle:Real;
			doc /* At end time have angle equal to 0 */
		}
		
		# goal respect_system_constraints{
			attribute trace[*]:Real;
			doc /* No system constraint violations in trace */
		}
		
		# goal minimize_trajectory_duration {
			attribute duration:Real;
			doc /* Minimize duration */
		}
		
		allocate no_swinging_motion to GantryCrane;
		allocate respect_system_constraints to GantryCrane;
		allocate minimize_trajectory_duration to GantryCrane;	
	}
}