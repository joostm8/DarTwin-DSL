library package DarTwin1 {
	// RDarTwin in SysML v2
	private import ScalarValues::*;
	
	part DarTwin {
		part twin_system {
			part digital_twin[*];
		}
		
		requirement goals[*]:Goal;
		
		part arbiter1:Arbiter;
		
		allocate goals to DarTwin.twin_system.digital_twin;
	}
	
	requirement def Goal {
		doc /* Our purpose */		
		subject digital_twin;
	}
	
	connection def Conflict {
		attribute explanation:String;
		end g1:Goal;
		end g2:Goal;
	}
	
	part def Arbiter {
		port inputs[2..*];
		port output[1];
	}
	
}

library package DarTwinMetadata{
	private import Metaobjects::SemanticMetadata;
	private import DarTwin1::*;
	
	metadata def <dartwin> DarTMetadata :> SemanticMetadata {
		:>> baseType default DarTwin meta SysML::PartUsage;
	}
	
	metadata def <twinsystem> TSMetadata :> SemanticMetadata {
		:>> baseType default DarTwin::twin_system meta SysML::PartUsage;
	}
	
	metadata def <digitaltwin> DTMetadata :> SemanticMetadata {
		:>> baseType default DarTwin::twin_system::digital_twin meta SysML::PartUsage;
	}
	
	metadata def <goal> GoalMetadata :> SemanticMetadata {
		:>> baseType = DarTwin::goals meta SysML::RequirementUsage;
	}
	
	connection confl:Conflict {
		end g1 references DarTwin.goals;
		end g2 references DarTwin.goals;
	}
	metadata def <vs> ConflictMetadata :> SemanticMetadata {
		:>> baseType = confl meta SysML::ConnectionUsage;
	}
	
	metadata def <arbiter> ArbiterMetadata :> SemanticMetadata{
		:>> baseType = DarTwin::arbiter1 meta SysML::PartUsage;
	}
	
}


