library package DarTwin {
	// RDarTwin in SysML v2
	private import ScalarValues::*;
	
	package DarTrans {		
		part core :> DarTwin;
		part before :> core;
		part afterw :> core;
	}


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
	private import DarTwin::*;
	
	metadata def <dartrans> DarTransMetadata :> SemanticMetadata{
		:>> baseType default DarTrans meta SysML::Package;
	}
	metadata def <dartwin_core> CoreMetadata :> SemanticMetadata{
		:>> baseType default DarTrans::core meta SysML::PartUsage;
	}
	
	metadata def <dartwin_before> BeforeMetadata :> SemanticMetadata{
		:>> baseType default DarTrans::before meta SysML::PartUsage;
	}

	metadata def <dartwin_after> AfterwMetadata :> SemanticMetadata{
		:>> baseType default DarTrans::afterw meta SysML::PartUsage;
	}
	
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


