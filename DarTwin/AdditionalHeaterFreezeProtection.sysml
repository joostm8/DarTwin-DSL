package AdditionalHeaterFreezeProtect_0 {
	doc /* 0. Copy start: FlatGreenComfort and change name of dartwin */
	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	
	#dartwin AdditionalHeaterNoFreeze   {
	
		#twinsystem EnergySavingThermostat  {
					
			connection g1 connect AdditionalHeaterNoFreeze.AT.UserComfortTemperature to EnergySaving.p1;
			connection g2 connect AdditionalHeaterNoFreeze.AT.RoomTemperature to ThermostatLogic.p2;
			connection g3 connect ThermostatLogic.p3 to AdditionalHeaterNoFreeze.AT.HeaterOnOff;
		
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
			
			connection g4 connect AdditionalHeaterNoFreeze.AT.Presence to EnergySaving.p2;
			connection g5 connect EnergySaving.p3 to ThermostatLogic.p1;						
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
		
		#goal lower_energy_when_absent :> lower_energy;
		
		allocate warm_comfort to EnergySavingThermostat.ThermostatLogic;
		allocate lower_energy_when_absent to EnergySavingThermostat.EnergySaving;
	
	} // AdditionalHeaterNoFreeze

}

package AdditionalHeaterFreezeProtect_1_2 {
	doc /* 1. Select potential evolution pattern: NewOutputTrans2 (from Basic) 
	 * 		2. Inherit NewOutputTrans2_before and make sure all of its elements
	 * 			are redefined (already)
	 * */
	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	private import NewOutputTrans2::*;
	
	
	#dartwin AdditionalHeaterNoFreeze :> NewOutput2_before   {
	
		#twinsystem FreezeProtectThermostat :>> TwinSystem  {
					
			connection g1 connect AdditionalHeaterNoFreeze.AT.UserComfortTemperature to EnergySaving.p1;
			connection g2 :>> c2 connect AdditionalHeaterNoFreeze.AT.RoomTemperature to ThermostatLogic.p2;
			connection g3 :>> c3 connect ThermostatLogic.p3 to AdditionalHeaterNoFreeze.AT.HeaterOnOff;
		
			#digitaltwin ThermostatLogic :> DT1 {
				port p1 :> p11;
				port p2 :> p12;
				port p3 :> p13;
			}
			
			#digitaltwin EnergySaving {
				port p1;
				port p2;
				port p3;
			}
			
			connection g4 connect AdditionalHeaterNoFreeze.AT.Presence to EnergySaving.p2;
			connection g5 :>> c1 connect EnergySaving.p3 to ThermostatLogic.p1;						
		} // EnergySavingThermostat		
		
		part :>> AT {
			port UserComfortTemperature :> ts1;
			port Presence;
			port RoomTemperature :> ts2;
			port HeaterOnOff :> ts3;			
		}
		
		#goal warm_comfort :> Goal1 {
			doc /* Warm Comfort */
			attribute room_temp:Real;
			constraint def_warm_comfort { room_temp > 21}
		}
				
		#goal lower_energy {
			attribute e:Real; // Energy kWh
			doc /* lower cumulated e than before */
		}
		
		#goal lower_energy_when_absent :> lower_energy;
		
		allocation :>> a1 allocate warm_comfort to FreezeProtectThermostat.ThermostatLogic;
		allocate lower_energy_when_absent to FreezeProtectThermostat.EnergySaving;
	
	} // AdditionalHeaterNoFreeze

}


package AdditionalHeaterFreezeProtect_3_4 {
	doc /* 3. NewOutput2_core is identical to NewOutput2_before (no deletions)
	 * 4. Inherit from NewOutput2_afterw and add domain specifics as specializations
	 * */
	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	private import NewOutputTrans2::*;
	
	
	#dartwin AdditionalHeaterNoFreeze :> NewOutput2_afterw   {
	
		#twinsystem FreezeProtectThermostat :>> TwinSystem  {
					
			connection g1 connect AdditionalHeaterNoFreeze.AT.UserComfortTemperature to EnergySaving.p1;
			connection g2 :>> c2 connect AdditionalHeaterNoFreeze.AT.RoomTemperature to ThermostatLogic.p2;
			connection g3 :>> c3 connect ThermostatLogic.p3 to AdditionalHeaterNoFreeze.AT.HeaterOnOff;
		
			#digitaltwin ThermostatLogic :> DT1 {
				port p1 :> p11;
				port p2 :> p12;
				port p3 :> p13;
			}
			
			#digitaltwin EnergySaving {
				port p1;
				port p2;
				port p3;
			}

			#digitaltwin FreezeProtection :>> DT2 {
				port :>> p21;
				port :>> p22;
			}
			
			connection g6 :>> c4 connect AdditionalHeaterNoFreeze.AT.UserComfortTemperature to FreezeProtection.p21; 
			connection g7 :>> c5 connect FreezeProtection.p22 to AdditionalHeaterNoFreeze.AT.HeaterOnOff2;

			
			connection g4 connect AdditionalHeaterNoFreeze.AT.Presence to EnergySaving.p2;
			connection g5 :>> c1 connect EnergySaving.p3 to ThermostatLogic.p1;						
		} // EnergySavingThermostat		
		
		part :>> AT {
			port UserComfortTemperature :> ts1;
			port Presence;
			port RoomTemperature :> ts2;
			port HeaterOnOff :> ts3;			
			port HeaterOnOff2 :> ts4;
		}
		
		#goal warm_comfort :> Goal1 {
			doc /* Warm Comfort */
			attribute room_temp:Real;
			constraint def_warm_comfort { room_temp > 21}
		}
				
		#goal lower_energy {
			attribute e:Real; // Energy kWh
			doc /* lower cumulated e than before */
		}
		
		#goal lower_energy_when_absent :> lower_energy;
		
		allocation :>> a1 allocate warm_comfort to FreezeProtectThermostat.ThermostatLogic;
		allocate lower_energy_when_absent to FreezeProtectThermostat.EnergySaving;
			
		#goal no_freezing :>> Goal2 {
			doc /* Room should never freeze */
			attribute t:Real; // temperature
			constraint def_no_freezing {t > 8}
		}			
		allocation :>> a2 allocate no_freezing to FreezeProtectThermostat.FreezeProtection;				

	
	} // AdditionalHeaterNoFreeze

}

package AdditionalHeaterFreezeProtect{
	doc /* 5. Flattening and possibly adding from NewOutput2_afterw what has not been redefined
	 * In this case, all elements of _afterw have been redefined
	 * Flattening will then only mean taking away the signs of the inheritance
	 * */
	private import ScalarValues::*;
	private import DarTwin1::*;
	private import DarTwinMetadata::*;
	
	
	#dartwin AdditionalHeaterNoFreeze {
	
		#twinsystem FreezeProtectThermostat {
					
			connection g1 connect AdditionalHeaterNoFreeze.AT.UserComfortTemperature to EnergySaving.p1;
			connection g2 connect AdditionalHeaterNoFreeze.AT.RoomTemperature to ThermostatLogic.p2;
			connection g3 connect ThermostatLogic.p3 to AdditionalHeaterNoFreeze.AT.HeaterOnOff;
		
			#digitaltwin ThermostatLogic{
				port p1;
				port p2;
				port p3;
			}
			
			#digitaltwin EnergySaving {
				port p1;
				port p2;
				port p3;
			}

			#digitaltwin FreezeProtection {
				port p21;
				port p22;
			}
			
			connection g6 connect AdditionalHeaterNoFreeze.AT.UserComfortTemperature to FreezeProtection.p21; 
			connection g7 connect FreezeProtection.p22 to AdditionalHeaterNoFreeze.AT.HeaterOnOff2;

			
			connection g4 connect AdditionalHeaterNoFreeze.AT.Presence to EnergySaving.p2;
			connection g5 connect EnergySaving.p3 to ThermostatLogic.p1;						
		} // EnergySavingThermostat		
		
		part AT {
			port UserComfortTemperature ;
			port Presence;
			port RoomTemperature ;
			port HeaterOnOff ;			
			port HeaterOnOff2 ;
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
		
		#goal lower_energy_when_absent :> lower_energy;
		
		allocation a1 allocate warm_comfort to FreezeProtectThermostat.ThermostatLogic;
		allocate lower_energy_when_absent to FreezeProtectThermostat.EnergySaving;
			
		#goal no_freezing {
			doc /* Room should never freeze */
			attribute t:Real; // temperature
			constraint def_no_freezing {t > 8}
		}			
		allocation a2 allocate no_freezing to FreezeProtectThermostat.FreezeProtection;				

	
	} // AdditionalHeaterNoFreeze

}