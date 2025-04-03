package AdditionalHeaterFreezeProtectionTrans {
	doc /* The NewOutput from original DarTwin paper */
	private import ScalarValues::*;
	private import DarTwin::*;
	private import DarTwinMetadata::*;
	private import OrthogonalWithNewOutputTrans::*;
	
	#dartrans AdditionalHeaterFreezeProtection {
		#dartwin_before AdditionalHeaterNoFreeze_before :> OrthogonalWithNewOutput.OrthogonalWithNewOutput_before   {
			doc /* Steps 0 and 1: Copy starting point and inherit and redefine the start of transition */
			#twinsystem FreezeProtectThermostat :>> TwinSystem  {
						
				connection g1 connect AdditionalHeaterFreezeProtection.AdditionalHeaterNoFreeze_before.AT.UserComfortTemperature to EnergySaving.p1;
				connection g2 :>> c2 connect AdditionalHeaterFreezeProtection.AdditionalHeaterNoFreeze_before.AT.RoomTemperature to ThermostatLogic.p2;
				connection g3 :>> c3 connect ThermostatLogic.p3 to AdditionalHeaterFreezeProtection.AdditionalHeaterNoFreeze_before.AT.HeaterOnOff;
			
				#digitaltwin ThermostatLogic :>> DT1 {
					port p1 :> p11;
					port p2 :> p12;
					port p3 :> p13;
				}
				
				#digitaltwin EnergySaving {
					port p1;
					port p2;
					port p3;
				}
				
				connection g4 connect AdditionalHeaterFreezeProtection.AdditionalHeaterNoFreeze_before.AT.Presence to EnergySaving.p2;
				connection g5 :>> c1 connect EnergySaving.p3 to ThermostatLogic.p1;						
			} // FreezeProtectThermostat	
			
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
		
		} // AdditionalHeaterNoFreeze_before
		
		#dartwin_core AdditionalHeaterNoFreeze_core = AdditionalHeaterNoFreeze_before; 
		// since OthogonalWithNewOutput has no difference between before and core i.e. no deletions
		
		#dartwin_after AdditionalHeaterNoFreeze_after :> AdditionalHeaterNoFreeze_core, OrthogonalWithNewOutput.OrthogonalWithNewOutput_after{
			#twinsystem :>> FreezeProtectThermostat :>> TwinSystem {
				#digitaltwin FreezeProtection :>> DT2 {
					port :>> p21;
					port :>> p22;
				}
				
				connection g6 :>> c4 connect AdditionalHeaterFreezeProtection.AdditionalHeaterNoFreeze_after.ATx.UserComfortTemperature to FreezeProtection.p21; 
				connection g7 :>> c5 connect FreezeProtection.p22 to AdditionalHeaterFreezeProtection.AdditionalHeaterNoFreeze_after.ATx.HeaterOnOff2;
			}
			part  ATx :>> AT {
				port HeaterOnOff2 :> OrthogonalWithNewOutput.OrthogonalWithNewOutput_after.AT.ts4;
			}
			#goal no_freezing :>> Goal2 {
				doc /* Room should never freeze */
				attribute t:Real; // temperature
				constraint def_no_freezing {t > 8}
			}			
			allocation :>> a2 allocate no_freezing to FreezeProtectThermostat.FreezeProtection;				

		}
	}
	
}