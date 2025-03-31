package OptimalControBase {
	doc /* Initial Gantry Crane system  */

	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	
	#dartwin DynamicPositioning {
		
		#twinsystem GantryCrane {
			
			#digitaltwin Trajectory {
				port p1;
				port p2;
				port p3;
				port p4;
			}
			
			connect DynamicPositioning.AT.MotorPosition to Trajectory.p1;
			connect DynamicPositioning.AT.SwingAngle to Trajectory.p2;
			connect DynamicPositioning.AT.MotorControllers to Trajectory.p3;
		
			#digitaltwin ObjectsInArea{
				port p1;
				port p2;
			}
			
			connect DynamicPositioning.AT.Camera to ObjectsInArea.p1;
			connect ObjectsInArea.p2 to Trajectory.p4;
		}
		
		part AT {
			port MotorPosition;
			port SwingAngle;
			port MotorControllers;
			port Camera;
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
		
		# goal respect_dynamic_position_constraints{
			attribute trace[*]:Real;
			doc /* No position constraint violations in trace */
		}
		
		# vs position_vs_system_constraints{
			end g1 references respect_system_constraints;
			end g2 references respect_dynamic_position_constraints;
			doc /* Union of all geometric constraints holds */
		}
		
		allocate no_swinging_motion to GantryCrane;
		allocate respect_system_constraints to GantryCrane.Trajectory;
		allocate minimize_trajectory_duration to GantryCrane.Trajectory;
		allocate respect_dynamic_position_constraints to GantryCrane.ObjectsInArea;
	}
}