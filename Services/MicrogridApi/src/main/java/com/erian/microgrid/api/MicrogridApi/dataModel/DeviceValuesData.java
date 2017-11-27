package com.erian.microgrid.api.MicrogridApi.dataModel;

import java.util.HashMap;
import java.util.Map;

public class DeviceValuesData {

	private Map<String, String> dict = new HashMap<String, String>();
	
	public DeviceValuesData() {
		
	}
	
	public void put(String key, String value) {
		dict.put(key, value);
		
	}
	
	public Map<String, String> getDict() {
		return dict;
	}

	public void setDict(Map<String, String> dict) {
		this.dict = dict;
	}

}
