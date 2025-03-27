package EnergyComfortFlatBase {
	doc /* Green comfort in a flat architecture */
	
	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
		
	#dartwin FlatGreenComfort   {
	
		#twinsystem EnergySavingThermostat  {
					
			connect FlatGreenComfort.AT.UserComfortTemperature to EnergySaving.p1;
			connect FlatGreenComfort.AT.RoomTemperature to ThermostatLogic.p2;
			connect ThermostatLogic.p3 to FlatGreenComfort.AT.HeaterOnOff;
		
			#digitaltwin ThermostatLogic {			
				port p1;
				port p2;
				port p3;
			}
			
			#digitaltwin EnergySaving {
				port p1;
				port p2;
				port p3;
			}
			
			connect FlatGreenComfort.AT.Presence to EnergySaving.p2;
			connect EnergySaving.p3 to ThermostatLogic.p1;						
		} // EnergySavingThermostat		
		
		part AT {
			port UserComfortTemperature;
			port Presence;
			port RoomTemperature;
			port HeaterOnOff;			
		}
		
		#goal warm_comfort {
			doc /* Warm Comfort */
			attribute room_temp:Real;
			constraint def_warm_comfort { room_temp > 21}
		}
				
		#goal lower_energy {
			attribute e:Real; // Energy kWh
			doc /* lower cumulated e than before */
		}
		
		#vs energyvscomfort {
			attribute :>> explanation = "Energy decrease vs Comfort";
			end g1 references lower_energy;
			end g2 references warm_comfort;
		}
				
		#goal lower_energy_when_absent :> lower_energy;
		
		allocate warm_comfort to EnergySavingThermostat.ThermostatLogic;
		allocate lower_energy_when_absent to EnergySavingThermostat.EnergySaving;
	
	} // FlatGreenComfort	
} // Energy Comfort Flat Base




