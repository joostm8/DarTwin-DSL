package OptimalControBase {
	doc /* Initial Gantry Crane system  */

	private import ScalarValues::*;
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	
	#dartwin ContainerConstraints {
		
		#twinsystem GantryCrane {
			
			#digitaltwin Trajectory {
				port p1;
				port p2;
				port p3;
				port p4;
				port p5;
				port p6;
			}
			
			connect ContainerConstraints.AT.MotorPosition to Trajectory.p1;
			connect ContainerConstraints.AT.SwingAngle to Trajectory.p2;
			connect ContainerConstraints.AT.MotorControllers to Trajectory.p3;
		
			#digitaltwin ObjectsInArea{
				port p1;
				port p2;
			}
			
			connect ContainerConstraints.AT.Camera to ObjectsInArea.p1;
			connect ObjectsInArea.p2 to Trajectory.p4;
			
			#digitaltwin Validation{
				port p1;
				port p2;
				port p3;
				port p4;
			}
			
			connect ContainerConstraints.AT.MotorPosition to Validation.p1;
			connect ContainerConstraints.AT.SwingAngle to Validation.p2;
			connect Trajectory.p3 to Validation.p3;
			connect Validation.p4 to ContainerConstraints.AT.ValidationMetrics;
		
			#digitaltwin ContainerSpecification{
				port p1;
				port p2;
				port p3;
			}
			
			#arbiter KineticConstraintArbiter{
				port p1 :> inputs;
				port p2 :> inputs;
				port p3 :> output;
				doc /* Picks strictest constraint between p1 and p2, outputs on p3 */
			}
			
			connect ContainerConstraints.AT.ContainerDatabase to ContainerSpecification.p1;
			connect ContainerConstraints.AT.ContainerCamera to ContainerSpecification.p2;
			connect ContainerSpecification.p3 to KineticConstraintArbiter.p1;
			connect KineticConstraintArbiter.p3 to Trajectory.p5;
			connect Trajectory.p6 to KineticConstraintArbiter.p2;
		}
		
		part AT {
			port MotorPosition;
			port SwingAngle;
			port MotorControllers;
			port Camera;
			port ValidationMetrics; // to Operator
			port ContainerDatabase; // from database
			port ContainerCamera;
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
		
		#goal respect_container_kinetic_constraints{
			attribute trace[*]:Real;
			doc /* No kinetic constraint violations in trace */
		}
		
		#vs kinetic_vs_system_constraints{
			end g1 references respect_system_constraints;
			end g2 references respect_container_kinetic_constraints;
			doc /* Strictest kinetic constraints hold */
		}
		
		allocate no_swinging_motion to GantryCrane;
		allocate respect_system_constraints to GantryCrane.Trajectory;
		allocate minimize_trajectory_duration to GantryCrane.Trajectory;
		allocate respect_dynamic_position_constraints to GantryCrane.ObjectsInArea;
		allocate continuous_validation to GantryCrane.Validation;
		allocate respect_container_kinetic_constraints to GantryCrane.ContainerSpecification;
	}
}