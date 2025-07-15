package OptimalControBase_0 {
	doc /* 0. Starting point: Initial Gantry Crane system  */

	private import ScalarValues::*;
	private import DarTwin::*;
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

doc /*
 * We note the following:
 * In the original we claimed to use the new output transformation.
 * Indeed, a new output was added, but not only a new output, along with
 * it a new DT that performed the validation.
 * The newoutput_core from which to inherit does not apply, since it assumes
 * the two DTs already exist (whereas only one exists).
 * 
 * Trying to apply the augmented transformation also doesn't work,
 * since in this case there is no DT1 to which DT2 will connect.
 * Here, the other way around holds up: DT1 connects to DT2, which
 * brings problems with inheriting the directional connections.
 */

package OptimalControBase_5 {
	doc /* 	5. Flattening, redefine all elements of _afterw
	 * 		This is the same content as 2-continuous-validation-dartwin.sysml
	 */

	private import ScalarValues::*;
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	
	#dartwin ContinuousValidation {
		
		#twinsystem GantryCrane {
			
			#digitaltwin Trajectory {
				port p1;
				port p2;
				port p3;
				port p4;
			}
			
			connect ContinuousValidation.AT.MotorPosition to Trajectory.p1;
			connect ContinuousValidation.AT.SwingAngle to Trajectory.p2;
			connect ContinuousValidation.AT.MotorControllers to Trajectory.p3;
		
			#digitaltwin ObjectsInArea{
				port p1;
				port p2;
			}
			
			connect ContinuousValidation.AT.Camera to ObjectsInArea.p1;
			connect ObjectsInArea.p2 to Trajectory.p4;
			
			#digitaltwin Validation{
				port p1;
				port p2;
				port p3;
				port p4;
			}
			
			connect ContinuousValidation.AT.MotorPosition to Validation.p1;
			connect ContinuousValidation.AT.SwingAngle to Validation.p2;
			connect Trajectory.p3 to Validation.p3;
			connect Validation.p4 to ContinuousValidation.AT.ValidationMetrics;
		}
		
		part AT {
			port MotorPosition;
			port SwingAngle;
			port MotorControllers;
			port Camera;
			port ValidationMetrics; // to Operator
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
		
		# goal continuous_validation{
			attribute validationmetrics[*]:Real;
			doc /* validationmetrics conform to thresholds */
		}
		
		allocate no_swinging_motion to GantryCrane;
		allocate respect_system_constraints to GantryCrane.Trajectory;
		allocate minimize_trajectory_duration to GantryCrane.Trajectory;
		allocate respect_dynamic_position_constraints to GantryCrane.ObjectsInArea;
		allocate continuous_validation to GantryCrane.Validation;
	}
}