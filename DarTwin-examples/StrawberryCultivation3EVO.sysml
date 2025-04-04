package StrawberryCultivation {
    doc /* based on Indoor Strawberry Cultivation System with Digital Twin, inspired by EnergyComfort3 */
    private import ScalarValues::*;
    private import DarTwin::*;           
    private import DarTwinMetadata::*;

	#dartrans StrawberryCultivationTrans {

	    #dartwin_core StrawberryCultivation {	
	        #twinsystem StrawberryController  {
	            // Updated connections with split sensors and renamed actuators
	            connect StrawberryCultivationTrans.StrawberryCultivation.CultivationSystem.Multisensor    to StrawberryDT.multisensor_input;
	//            connect StrawberryCultivation.CultivationSystem.SoilMoisture   to StrawberryDT.soilMoisture_input;
	            connect StrawberryDT.actuator_output_ventilation to StrawberryCultivationTrans.StrawberryCultivation.CultivationSystem.ActuatorVentilation;
	//            connect StrawberryDT.actuator_output_irrigation  to StrawberryCultivation.CultivationSystem.ActuatorIrrigation;
	            connect StrawberryDT.actuator_output_human       to StrawberryCultivationTrans.StrawberryCultivation.CultivationSystem.HumanActuator;
	
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
	            port Multisensor;
	//            port SoilMoisture           : SoilMoistureSensor;
	            port ActuatorVentilation;
	//            port ActuatorIrrigation     : ActuatorIrrigation;
	            port HumanActuator;
	        }
	
	    } // StrawberryCultivation_core
	    
	    #dartwin_before StrawberryCultivation_before :> StrawberryCultivation{
	    	#twinsystem :>> StrawberryController {
	            connect StrawberryCultivationTrans.StrawberryCultivation_before.CultivationSystem.SoilMoistureSensor   to StrawberryDT.soilMoisture_input;
	            connect StrawberryDT.actuator_output_irrigation  to StrawberryCultivationTrans.StrawberryCultivation_before.CultivationSystem.ActuatorIrrigation;
	    		
	    		#digitaltwin :>> StrawberryDT{
	              port soilMoisture_input;
	              port actuator_output_irrigation;    			
	    		}
	    		
	    	}
	    	
			part :>> CultivationSystem {
	        	port SoilMoistureSensor;
	        	port ActuatorIrrigation;    			
			}
	    } // StrawberryCultivation_before
    

    	#dartwin_after StrawberryCultivation_afterw :> StrawberryCultivation{
	    	#twinsystem :>> StrawberryController {
	            // Hydro sensors -> DT inputs
	            connect StrawberryCultivationTrans.StrawberryCultivation_afterw.CultivationSystem.NutrientSensor to StrawberryDT.nutrient_input;
	            connect StrawberryCultivationTrans.StrawberryCultivation_afterw.CultivationSystem.DissolvedOxygenSensor to StrawberryDT.dissolvedOxygen_input;
	            connect StrawberryCultivationTrans.StrawberryCultivation_afterw.CultivationSystem.pHSensor to StrawberryDT.pH_input;
	
	           	connect StrawberryDT.actuator_output_pump to StrawberryCultivationTrans.StrawberryCultivation_afterw.CultivationSystem.ActuatorPump;
	    		
	    		#digitaltwin :>> StrawberryDT{
		            port nutrient_input;
		            port dissolvedOxygen_input;
		            port pH_input;
		            port actuator_output_pump;
	    		}    		
	    	}
    	
			part :>> CultivationSystem {
	            port NutrientSensor;
	            port DissolvedOxygenSensor;
	            port pHSensor;
	            port ActuatorPump;
	        }
		} // StrawberryCultivation_after
    } // StrawberryCultivationTrans


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
}
