package com.erian.ict.microgrid.mapper;

import com.erian.ict.microgrid.domain.BICConverter;
import com.erian.ict.microgrid.domain.BatteryConverter;
import com.erian.ict.microgrid.domain.PVConverter;
import org.json.simple.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Set;
import java.util.TimeZone;


/**
 * Created by nhdevika on 2/15/2017.
 */

public class ConverterMapper {

    public static BatteryConverter mapBatteryConverterData(JSONObject batteryJson,String deviceId) {
        BatteryConverter batteryConverter = new BatteryConverter();
        SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        isoFormat.setTimeZone(TimeZone.getTimeZone("Asia/Singapore"));
        try {

            batteryConverter.setChannel1Status((long)batteryJson.get("CH1_ONOFF_STATUS"));
            batteryConverter.setInductorCurrentChannel1((double)batteryJson.get("INDUCTOR_CUR_CH1"));
            batteryConverter.setInductorCurrentChannel2((double)batteryJson.get("INDUCTOR_CUR_CH2"));
            batteryConverter.setInductorCurrentChannel3((double)batteryJson.get("INDUCTOR_CUR_CH3"));
            batteryConverter.setOutputCurrent((double)batteryJson.get("OUTPUT_CUR"));
            batteryConverter.setRefVolumeConfirm((double)batteryJson.get("REF_VOL_CONFIRM"));
            batteryConverter.setDroopCoefConfirm((double)batteryJson.get("DROOP_COEF_CONFIRM"));
            batteryConverter.setChannel2Status((long)batteryJson.get("CH2_ONOFF_STATUS"));
            batteryConverter.setChannel3Status((long)batteryJson.get("CH3_ONOFF_STATUS"));
            batteryConverter.setInputRelayStatus((long)batteryJson.get("INPUT_RELAY_STATUS"));
            batteryConverter.setOutputRelayStatus((long)batteryJson.get("OUTPUT_RELAY_STATUS"));
            batteryConverter.setMode((long)batteryJson.get("BAT_MODE"));
            batteryConverter.setFaultMessage((long)batteryJson.get("FAULT_MESSAGE"));
            batteryConverter.setHeatSinkTemp((double)batteryJson.get("HEATSINK_TEMP"));
            batteryConverter.setRefPowerConfirm((double)batteryJson.get("REF_POW_CONFIRM"));
            batteryConverter.setVoltage((double)batteryJson.get("BAT_VOL"));
            batteryConverter.setDCBusVolatge((double)batteryJson.get("DC_BUS_VOL"));
            batteryConverter.setOperatingPower((String) batteryJson.get("OPERATING_POW"));
            batteryConverter.setUpdatedTimestamp(isoFormat.parse(isoFormat.format(Math.round((double)batteryJson.get("datetime1"))*1000)));
            batteryConverter.setDeviceId(deviceId);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return batteryConverter;
    }

    public static PVConverter mapPVConverterData(JSONObject pvJson, String deviceId) {
        PVConverter pvConverter = new PVConverter();
        SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        isoFormat.setTimeZone(TimeZone.getTimeZone("Asia/Singapore"));

        try {
            pvConverter.setVoltageChannel1((double)pvJson.get("CH1_VOL"));
            pvConverter.setVoltageChannel2((double)pvJson.get("CH2_VOL"));
            pvConverter.setVoltageChannel3((double)pvJson.get("CH3_VOL"));
            pvConverter.setPriorChannel1((long)pvJson.get("CH1_PRIOR"));
            pvConverter.setPriorChannel2((long)pvJson.get("CH2_PRIOR"));
            pvConverter.setPriorChannel3((long)pvJson.get("CH3_PRIOR"));
            pvConverter.setModeChannel1((long)pvJson.get("CH1_MODE"));
            pvConverter.setModeChannel2((long)pvJson.get("CH2_MODE"));
            pvConverter.setModeChannel3((long)pvJson.get("CH3_MODE"));
            pvConverter.setReferencePowerChannel1((double)pvJson.get("CH1_REF_POW"));
            pvConverter.setReferencePowerChannel2((double)pvJson.get("CH2_REF_POW"));
            pvConverter.setReferencePowerChannel3((double)pvJson.get("CH3_REF_POW"));
            pvConverter.setPowerChannel1((String) pvJson.get("CH1_POWER"));
            pvConverter.setPowerChannel2((String) pvJson.get("CH2_POWER"));
            pvConverter.setPowerChannel3((String) pvJson.get("CH3_POWER"));
            pvConverter.setInductorCurrentChannel1((double)pvJson.get("INDUCTOR_CUR_CH1"));
            pvConverter.setInductorCurrentChannel2((double)pvJson.get("INDUCTOR_CUR_CH2"));
            pvConverter.setInductorCurrentChannel3((double)pvJson.get("INDUCTOR_CUR_CH3"));
            pvConverter.setOutputCurrent((double)pvJson.get("OUTPUT_CUR"));
            pvConverter.setVoltageForDC((double)pvJson.get("DC_BUS_VOL"));
            pvConverter.setOutputRelayStatus((long)pvJson.get("OUTPUT_RELAY_STATUS"));
            pvConverter.setInputRelayStatus((long)pvJson.get("INPUT_RELAY_STATUS"));
            pvConverter.setDeviceId(deviceId);
            pvConverter.setUpdatedTimestamp(isoFormat.parse(isoFormat.format(Math.round((double)pvJson.get("datetime1"))*1000)));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pvConverter;
    }

    public static BICConverter mapBICConverterData(JSONObject bicJson, String deviceId) {
        BICConverter bicConverter = new BICConverter();
        SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        isoFormat.setTimeZone(TimeZone.getTimeZone("Asia/Singapore"));

        try {
            bicConverter.setMode((long)bicJson.get("Operating_mode"));
            bicConverter.setActivePowerReference((long)bicJson.get("Active_power_reference"));
            bicConverter.setDroopVPCoefficientForDC((double)bicJson.get("DC_VP_droop_coefficient"));
            bicConverter.setReactivePowerReferenceRec((long)bicJson.get("Reactive_power_reference_rec"));
            bicConverter.setCurrentPhaseBForAC((double)bicJson.get("AC_bus_current_B"));
            bicConverter.setCurrentForDC((double)bicJson.get("DC_bus_current"));
            bicConverter.setVoltagePhaseAForAC((double)bicJson.get("AC_bus_voltage_phase_A"));
            bicConverter.setCurrentPhaseAForAC((double)bicJson.get("AC_bus_current_A"));
            bicConverter.setRefVoltageForDC((double)bicJson.get("DC_Reference_voltage"));
            bicConverter.setHeatSinkTemperature((double)bicJson.get("Heat_sink_temperature"));
            bicConverter.setReactivePowerReference((long)bicJson.get("Reactive_power_reference"));
            bicConverter.setFrequencyForAC((double)bicJson.get("AC_bus_Frequency"));
            bicConverter.setOutputPowerForDC((long)bicJson.get("DC_output_power"));
            bicConverter.setDroopFPCoefficientForAC((double)bicJson.get("AC_fP_droop_coefficient"));
            bicConverter.setRelayStatusForDC((long)bicJson.get("DC_relay_ON_OFF_status"));
            bicConverter.setEnvironmentTemperature((double)bicJson.get("Environment_temperature"));
            bicConverter.setRefVoltageForAC((double)bicJson.get("AC_Reference_voltage"));
            bicConverter.setVoltagePhaseCForAC((double)bicJson.get("AC_bus_voltage_phase_C"));
            bicConverter.setOutputActivePowerForAC((long)bicJson.get("AC_output_active_power"));
            bicConverter.setDeviceTemperature((double)bicJson.get("Device_temperature"));
            bicConverter.setDroopVQCoefficientForAC((double)bicJson.get("AC_VQ_droop_coefficient"));
            bicConverter.setOutputReactivePowerForAC((long)bicJson.get("AC_output_reactive_power"));
            bicConverter.setFaultMessage((long)bicJson.get("Fault_message"));
            bicConverter.setVoltageForDC((double)bicJson.get("DC_bus_voltage"));
            bicConverter.setRefFrequencyForAC((double)bicJson.get("AC_Reference_frequency"));
            bicConverter.setOperationStatus((long)bicJson.get("Operation_status"));
            bicConverter.setVoltagePhaseBForAC((double)bicJson.get("AC_bus_voltage_phase_B"));
            bicConverter.setIsolateStatus((long)bicJson.get("isolate_status"));
            bicConverter.setCurrentPhaseCForAC((double)bicJson.get("AC_bus_current_C"));
            bicConverter.setRelayStatusForAC((long)bicJson.get("AC_relay_ON_OFF_status"));
            bicConverter.setDeviceId(deviceId);
            bicConverter.setUpdatedTimestamp(isoFormat.parse(isoFormat.format(Math.round((double)bicJson.get("datetime1"))*1000)));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bicConverter;
    }
}
