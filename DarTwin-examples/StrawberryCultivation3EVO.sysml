package StrawberryCultivation {
    private import ScalarValues::*;
    private import DarTwin::*;
    private import DarTwinMetadata::*;

    #dartwin StrawberryCultivation {
        #twinsystem StrawberryController {
            

            #digitaltwin StrawberryDT {
                port multisensor_input;
                
                port actuator_output_ventilation;
                port actuator_output_irrigation;
                port actuator_output_human;
            }

            part CultivationSystem {
                port Multisensor;
                port ActuatorVentilation;
                port ActuatorIrrigation;
                port HumanActuator;
            }
            
            connect CultivationSystem.Multisensor                        to StrawberryDT.multisensor_input;
            connect StrawberryDT.actuator_output_ventilation to CultivationSystem.ActuatorVentilation;
            connect StrawberryDT.actuator_output_irrigation  to CultivationSystem.ActuatorIrrigation;
            connect StrawberryDT.actuator_output_human        to CultivationSystem.HumanActuator;
        }

        #goal increase_yield {
            attribute yield: Real; // kg per season
            doc /* maximize strawberry yield under optimal conditions */
        }
        #goal apply_decreased_water {
            attribute water: Real; // liters per season
            doc /* minimize water usage moderately */
        }
        allocate increase_yield to StrawberryController.StrawberryDT;
        allocate apply_decreased_water to StrawberryController.StrawberryDT;
    }
}
