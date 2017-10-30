package com.erian.ict.microgrid.mapper;

import com.erian.ict.microgrid.domain.*;
import com.erian.ict.microgrid.domain.model.*;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;

import javax.annotation.PostConstruct;


/**
 * Created by nhdevika on 2/15/2017.
 */
@Component
public class ConverterMapper {
	
	@Autowired
	DataPointValueDao dao;
	
	@Autowired
	DataPointDao dpDao;
	
	public static Map<String,Integer> DEVICES = Maps.newHashMap();
	
	static {
		DEVICES.put("pv2",	1025);
		DEVICES.put("pv1",	1026);
		DEVICES.put("battery1",	1027);
		DEVICES.put("battery2",	1028);
		DEVICES.put("bic1",	1029);
		DEVICES.put("bic2",	1020);
	}
	public static Map<String,Integer> pv1Map = null;
	public static Map<String,Integer> pv2Map = null;
	public static Map<String,Integer> bat1Map = null;
	public static Map<String,Integer> bat2Map = null;
	public static Map<String,Integer> bic1Map = null;
	public static Map<String,Integer> bic2Map = null;
	
	@PostConstruct
	public void getMap(){
	 pv1Map = getMap("pv1");
	 pv2Map = getMap("pv2");
	 bat1Map = getMap("battery1");
	 bat2Map = getMap("battery2");
	 bic1Map = getMap("bic1");
	 bic2Map = getMap("bic2");
	}
	
	public Map<String,Integer> getMap(String device){
		List<DataPoint> ls = null;
		Integer deviceId = DEVICES.get(device);
		if(deviceId != null)
			ls = dpDao.getByDeviceId(deviceId);
		else return null;
		if(ls.isEmpty()) return null;
		Map<String,Integer> map = Maps.newHashMap();
		for(DataPoint dp : ls){
			map.put(dp.name, dp.id);
		}
		return map;
	}

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
            batteryConverter.setBatSoc((Integer)batteryJson.get("BAT_SOC"));
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

    
    public void storeConvData(JSONObject json, String deviceId) {
    	
    	List<DataPointValue> ls = Lists.newArrayList();
    	Map<String, Integer> map = null;
    	
    	switch (deviceId){
    		case "pv2":
    			map = pv2Map;
    		case "pv1":
    			map = pv1Map;
    			break;
    		case "bic1":
    			map = bic1Map;
    			break;
    		case "bic2":
    			map = bic2Map;
    			break;
    		case "battery1":
    			map = bat1Map;
    			break;
    		case "battery2":
    			map = bat2Map;
    			break;
    		default:
    			System.err.println("unknown device type");
    	}		
    	if(map != null){
    		Date d = new Date();
    		for(String key: map.keySet()){
    			Object obj = json.get(key);
    			Integer i = map.get(key);
    			if(obj != null && i != null){
    				DataPointValue val = new DataPointValue();
        	    	val.value = (String)obj;
        	    	val.dataPointId = i;
        	    	val.timestamp = d;
        	    	ls.add(val);
    			}
    		}
    		dao.save(ls);
    	}
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
    /*    
    
    public static Map<String,Integer> pv1Map = Maps.newHashMap();

    public static Map<String,Integer> bat1Map = Maps.newHashMap();
    public static Map<String,Integer> bat2Map = Maps.newHashMap();
    public static Map<String,Integer> bic1Map = Maps.newHashMap();
    public static Map<String,Integer> bic2Map = Maps.newHashMap();

	static String[] BICs = {
			 "Operating_mode","Active_power_reference","DC_VP_droop_coefficient","Reactive_power_reference_rec",
			 "AC_bus_current_B","DC_bus_current","AC_bus_voltage_phase_A","AC_bus_current_A","DC_Reference_voltage",
			 "Heat_sink_temperature","Reactive_power_reference","AC_bus_Frequency","DC_output_power","AC_fP_droop_coefficient",
			 "DC_relay_ON_OFF_status","Environment_temperature","AC_Reference_voltage","AC_bus_voltage_phase_C",
			 "AC_output_active_power","Device_temperature","AC_VQ_droop_coefficient","AC_output_reactive_power","Fault_message",
			 "DC_bus_voltage","AC_Reference_frequency","Operation_status","AC_bus_voltage_phase_B","isolate_status","AC_bus_current_C","AC_relay_ON_OFF_status"
	};
	
	static String[] BATs = {
			"CH1_ONOFF_STATUS","INDUCTOR_CUR_CH1","INDUCTOR_CUR_CH2","INDUCTOR_CUR_CH3","OUTPUT_CUR","REF_VOL_CONFIRM",
			"DROOP_COEF_CONFIRM","CH2_ONOFF_STATUS","CH3_ONOFF_STATUS","INPUT_RELAY_STATUS","OUTPUT_RELAY_STATUS","BAT_MODE",
			"BAT_SOC","FAULT_MESSAGE","HEATSINK_TEMP","REF_POW_CONFIRM","BAT_VOL","DC_BUS_VOL","OPERATING_POW"
			};
    
    
  public static Map<String,Integer> pv2Map = Maps.newHashMap();
    static{
    	pv2Map.put("CH1_VOL",1076);
    	pv2Map.put("CH2_VOL",1077);
    	pv2Map.put("CH3_VOL",1078);
    	pv2Map.put("CH1_PRIOR",1079);
    	pv2Map.put("CH2_PRIOR",1080);
    	pv2Map.put("CH3_PRIOR",1081);
    	pv2Map.put("CH1_MODE",1082);
    	pv2Map.put("CH2_MODE",1083);
    	pv2Map.put("CH3_MODE" ,1084);
    	pv2Map.put("CH1_REF_POW",1085);
    	pv2Map.put("CH2_REF_POW",1086);
    	pv2Map.put("CH3_REF_POW",1087);
    	pv2Map.put("CH1_POWER",1088);
    	pv2Map.put("CH2_POWER",1089);
    	pv2Map.put("CH3_POWER",1090);
    	pv2Map.put("INDUCTOR_CUR_CH1",1091);
    	pv2Map.put("INDUCTOR_CUR_CH2",1092);
    	pv2Map.put("INDUCTOR_CUR_CH3",1093);
    	pv2Map.put("OUTPUT_CUR",1094);
    	pv2Map.put("DC_BUS_VOL",1095);
    	pv2Map.put("OUTPUT_RELAY_STATUS",1096);
    	pv2Map.put("INPUT_RELAY_STATUS",1097);
    	
    	pv1Map.put("CH1_VOL",1120);
    	pv1Map.put("CH2_VOL",1121);
    	pv1Map.put("CH3_VOL",1122);
    	pv1Map.put("CH1_PRIOR",1123);
    	pv1Map.put("CH2_PRIOR",1124);
    	pv1Map.put("CH3_PRIOR",1125);
    	pv1Map.put("CH1_MODE",1126);
    	pv1Map.put("CH2_MODE",1127);
    	pv1Map.put("CH3_MODE" ,1128);
    	pv1Map.put("CH1_REF_POW",1129);
    	pv1Map.put("CH2_REF_POW",1130);
    	pv1Map.put("CH3_REF_POW",1131);
    	pv1Map.put("CH1_POWER",1132);
    	pv1Map.put("CH2_POWER",1133);
    	pv1Map.put("CH3_POWER",1134);
    	pv1Map.put("INDUCTOR_CUR_CH1",1135);
    	pv1Map.put("INDUCTOR_CUR_CH2",1136);
    	pv1Map.put("INDUCTOR_CUR_CH3",1137);
    	pv1Map.put("OUTPUT_CUR",1138);
    	pv1Map.put("DC_BUS_VOL",1139);
    	pv1Map.put("OUTPUT_RELAY_STATUS",1140);
    	pv1Map.put("INPUT_RELAY_STATUS",1141);
    	
		bic1Map.put("Operating_mode",1180);
		bic1Map.put("Active_power_reference",1181);
		bic1Map.put("DC_VP_droop_coefficient",1182);
		bic1Map.put("Reactive_power_reference_rec",1183);
		bic1Map.put("AC_bus_current_B",1184);
		bic1Map.put("DC_bus_current",1185);
		bic1Map.put("AC_bus_voltage_phase_A",1186);
		bic1Map.put( "AC_bus_current_A",1187);
		bic1Map.put("DC_Reference_voltage",1188);
		bic1Map.put("Heat_sink_temperature",1189);
		bic1Map.put("Reactive_power_reference",1190);
		bic1Map.put("AC_bus_Frequency",1191);
		bic1Map.put("DC_output_power",1192);
		bic1Map.put("AC_fP_droop_coefficient",1193);
		bic1Map.put("DC_relay_ON_OFF_status",1194);
		bic1Map.put("Environment_temperature",1195);
		bic1Map.put("AC_Reference_voltage",1196);
		bic1Map.put("AC_bus_voltage_phase_C",1197);
		bic1Map.put("AC_output_active_power",1198);
		bic1Map.put("Device_temperature",1199);
		bic1Map.put("AC_VQ_droop_coefficient",1200);
		bic1Map.put("AC_output_reactive_power",1201);
		bic1Map.put("Fault_message",1202);
		bic1Map.put("DC_bus_voltage",1203);
		bic1Map.put("AC_Reference_frequency",1204);
		bic1Map.put("Operation_status",1205);
		bic1Map.put("AC_bus_voltage_phase_B",1206);
		bic1Map.put("isolate_status",1207);
		bic1Map.put("AC_bus_current_C",1208);
		bic1Map.put("AC_relay_ON_OFF_status",1209);
		
		
		bic2Map.put("Operating_mode",1240);
		bic2Map.put("Active_power_reference",1241);
		bic2Map.put("DC_VP_droop_coefficient",1242);
		bic2Map.put("Reactive_power_reference_rec",1243);
		bic2Map.put("AC_bus_current_B",1244);
		bic2Map.put("DC_bus_current",1245);
		bic2Map.put("AC_bus_voltage_phase_A",1246);
		bic2Map.put( "AC_bus_current_A",1247);
		bic2Map.put("DC_Reference_voltage",1248);
		bic2Map.put("Heat_sink_temperature",1249);
		bic2Map.put("Reactive_power_reference",1250);
		bic2Map.put("AC_bus_Frequency",1251);
		bic2Map.put("DC_output_power",1252);
		bic2Map.put("AC_fP_droop_coefficient",1253);
		bic2Map.put("DC_relay_ON_OFF_status",1254);
		bic2Map.put("Environment_temperature",1255);
		bic2Map.put("AC_Reference_voltage",1256);
		bic2Map.put("AC_bus_voltage_phase_C",1257);
		bic2Map.put("AC_output_active_power",1258);
		bic2Map.put("Device_temperature",1259);
		bic2Map.put("AC_VQ_droop_coefficient",1260);
		bic2Map.put("AC_output_reactive_power",1261);
		bic2Map.put("Fault_message",1262);
		bic2Map.put("DC_bus_voltage",1263);
		bic2Map.put("AC_Reference_frequency",1264);
		bic2Map.put("Operation_status",1265);
		bic2Map.put("AC_bus_voltage_phase_B",1266);
		bic2Map.put("isolate_status",1267);
		bic2Map.put("AC_bus_current_C",1268);
		bic2Map.put("AC_relay_ON_OFF_status",1269);
    }*/
}
