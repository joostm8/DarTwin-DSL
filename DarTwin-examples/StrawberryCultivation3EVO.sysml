package StrawberryCultivation {
    doc /* based on Indoor Strawberry Cultivation System with Digital Twin, inspired by EnergyComfort3 */
    private import ScalarValues::*;
    private import DarTwin1::*;           
    private import DarTwinMetadata::*;

    #dartwin StrawberryCultivation {

        #twinsystem StrawberryController  {
            // Updated connections with split sensors and renamed actuators
            connect StrawberryCultivation.CultivationSystem.FieldMultisensor    to StrawberryDT.multisensor_input;
//            connect StrawberryCultivation.CultivationSystem.FieldSoilMoisture   to StrawberryDT.soilMoisture_input;
            connect StrawberryDT.actuator_output_ventilation to StrawberryCultivation.CultivationSystem.FieldActuatorVentilation;
//            connect StrawberryDT.actuator_output_irrigation  to StrawberryCultivation.CultivationSystem.FieldActuatorIrrigation;
            connect StrawberryDT.actuator_output_human       to StrawberryCultivation.CultivationSystem.FieldHumanActuator;

            #digitaltwin StrawberryDT {
                port multisensor_input;
//              port soilMoisture_input;
                port actuator_output_ventilation;
//                port actuator_output_irrigation;
                port actuator_output_human;
            }

        } // StrawberryController

        #goal increase_yield {
            attribute yield:Real; // yield in kg per season
            doc /* maximize strawberry yield under optimal growing conditions */
        }

        #goal apply_decreased_water {
            attribute water:Real; // water usage in liters
            doc /* apply a moderately decreased amount of water usage */
        }
        allocate increase_yield to StrawberryController.StrawberryDT;
        allocate apply_decreased_water to StrawberryController.StrawberryDT;

        part CultivationSystem { // This is the Actual System
            port FieldMultisensor            : Multisensor;
//            port FieldSoilMoisture           : SoilMoistureSensor;
            port FieldActuatorVentilation    : ActuatorVentilation;
//            port FieldActuatorIrrigation     : ActuatorIrrigation;
            port FieldHumanActuator          : HumanActuator;
        }

    } // StrawberryCultivation
    
    #dartwin StrawberryCultivation_before :> StrawberryCultivation{
    	#twinsystem :>> StrawberryController {
            connect StrawberryCultivation_before.CultivationSystem.FieldSoilMoisture   to StrawberryDT.soilMoisture_input;
            connect StrawberryDT.actuator_output_irrigation  to StrawberryCultivation_before.CultivationSystem.FieldActuatorIrrigation;
    		
    		#digitaltwin :>> StrawberryDT{
              port soilMoisture_input;
              port actuator_output_irrigation;    			
    		}
    		
    	}
    	
		part :>> CultivationSystem {
        	port FieldSoilMoisture           : SoilMoistureSensor;
        	port FieldActuatorIrrigation     : ActuatorIrrigation;    			
		}
    }


    #dartwin StrawberryCultivation_afterw :> StrawberryCultivation{
    	#twinsystem :>> StrawberryController {
            // Hydro sensors -> DT inputs
            connect StrawberryCultivation_afterw.CultivationSystem.NutrientSensor_output to StrawberryDT.nutrient_input;
            connect StrawberryCultivation_afterw.CultivationSystem.DissolvedOxygen_output to StrawberryDT.dissolvedOxygen_input;
            connect StrawberryCultivation_afterw.CultivationSystem.pHSensor_output to StrawberryDT.pH_input;

           	connect StrawberryDT.actuator_output_pump to StrawberryCultivation_afterw.CultivationSystem.ActuatorPumpDevice_input;
    		
    		#digitaltwin :>> StrawberryDT{
	            port nutrient_input: ~NutrientSensor ;
	            port dissolvedOxygen_input: ~DissolvedOxygenSensor;
	            port pH_input: ~pHSensor;
	            port actuator_output_pump: ~ActuatorPump;
    		}
    		
    	}
    	
		part :>> CultivationSystem {
            port NutrientSensor_output     : NutrientSensor;
            part DissolvedOxygen_output    : DissolvedOxygenSensor;
            part pHSensor_output           : pHSensor;
            part ActuatorPumpDevice_input  : ActuatorPump;
		}
    }

    //////////////////////////////////////////////////////////////////////////
    // Domain Part Definitions
    //////////////////////////////////////////////////////////////////////////

    port Multisensor {
        attribute temperature   : Real;
        attribute humidity      : Real;
        attribute CO2           : Real;
        attribute noise         : Real;
    }

    port SoilMoistureSensor {
        attribute soilMoisture  : Real;
    }

    port ActuatorVentilation {
        attribute ventilation   : Boolean;
    }

    port ActuatorIrrigation {
        attribute irrigation    : Boolean;
    }

    port HumanActuator {
        attribute human         : Boolean;
    }
    
    port NutrientSensor {
        attribute nutrientConcentration : Real;
    }

    port DissolvedOxygenSensor {
        attribute dissolvedOxygen : Real;
    }

    port pHSensor {
        attribute pH : Real;
    }
    
    port ActuatorPump {
        attribute pump : Boolean;
    }

    // Note: Duplicate HumanActuator removed.

}
