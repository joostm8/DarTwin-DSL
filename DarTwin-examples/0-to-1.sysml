package OptimalControBase_0 {
	doc /* 0. Starting point: Initial Gantry Crane system  */

	private import ScalarValues::*;
	private import DarTwin1::*;
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

package OptimalControBase_1_2 {
	doc /* 	1. Select evolution pattern: AugmentedTrans
	 * 		2. Inherit AugmentedTrans_before and make sure all of its elements are redefined.
	 */

	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	private import AugmentedTrans::*;
	
	#dartwin OptimalControl :> augmented_before {
		
		#twinsystem GantryCrane :> TwinSystem {
			
			#digitaltwin Trajectory :> DT1 {
				port p1;
				port p2 :> p12;
				port p3 :> p13;
			}
			
			connection g1 :> c2 connect OptimalControl.AT.MotorPosition to Trajectory.p1;
			connection g2 connect OptimalControl.AT.SwingAngle to Trajectory.p2; // missing in the before template
			connection g3 :> c3 connect OptimalControl.AT.MotorControllers to Trajectory.p3;
		}
		
		part :>> AT {
			port MotorPosition :> ts2;
			port SwingAngle; // missing in the before template
			port MotorControllers :> ts3;
		}
		
		# goal no_swinging_motion :> Goal1{
			attribute angle:Real;
			doc /* At end time have angle equal to 0 */
		}
		
		# goal respect_system_constraints{ // missing in the before template
			attribute trace[*]:Real;
			doc /* No system constraint violations in trace */
		}
		
		# goal minimize_trajectory_duration { // missing in the before template
			attribute duration:Real;
			doc /* Minimize duration */
		}
		
		allocation :>> a1 allocate no_swinging_motion to GantryCrane;
		allocate respect_system_constraints to GantryCrane; // missing in the before template
		allocate minimize_trajectory_duration to GantryCrane;	//missing in the before template
	}
}

package OptimalControBase_3_4 {
	doc /* 	3. augmented_core is identical to augmented_before, since no deletions.
	 * 		4. Inherit from augmented_afterw and add domain specifics as specializations
	 */

	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	private import AugmentedTrans::*;
	
	#dartwin OptimalControl :> augmented_afterw {
		
		#twinsystem GantryCrane :> TwinSystem {
			
			#digitaltwin Trajectory :> DT1 {
				port p1;
				port p2 :> p12;
				port p3 :> p13;
				port p4 :> p11;
			}
			
			connection g1 :> c2 connect OptimalControl.AT.MotorPosition to Trajectory.p1;
			connection g2 connect OptimalControl.AT.SwingAngle to Trajectory.p2; // missing in the before template
			connection g3 :> c3 connect OptimalControl.AT.MotorControllers to Trajectory.p3;
		
			#digitaltwin ObjectsInArea :> DT2{
				port p1 :> p22;
				port p2 :> p23;
			}
			
			// connection c4 doesn't exist and can't be inherited.
			connection g4 :> c5 connect OptimalControl.AT.Camera to ObjectsInArea.p1;
			connection g5 :> c6 connect ObjectsInArea.p2 to Trajectory.p4;
		}
		
		part :>> AT {
			port MotorPosition :> ts2;
			port SwingAngle; // missing in the before template
			port MotorControllers :> ts3;
			port Camera :> ts4;
			// additional port ts1 doesn't exist and can't be inherited
		}
		
		# goal no_swinging_motion :> Goal1{
			attribute angle:Real;
			doc /* At end time have angle equal to 0 */
		}
		
		# goal respect_system_constraints{ // missing in the before template
			attribute trace[*]:Real;
			doc /* No system constraint violations in trace */
		}
		
		# goal minimize_trajectory_duration { // missing in the before template
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
		
		allocation :>> a1 allocate no_swinging_motion to GantryCrane;
		allocate respect_system_constraints to GantryCrane; // missing in the before template
		allocate minimize_trajectory_duration to GantryCrane;	//missing in the before template
		allocation :>> a2 allocate respect_dynamic_position_constraints to GantryCrane.ObjectsInArea;
	}
}

package OptimalControBase_5 {
	doc /* 	5. Flattening, redefine all elements of _afterw
	 * 		This is the same content as 1-dynamic-positioning-dartwin.sysml
	 */

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