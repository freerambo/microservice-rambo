/*
 * Copyright: Energy Research Institute @ NTU
 * converters-service
 * com.erian.ict.microgrid.service -> DataPaser.java
 * Created on 25 Oct 2017-7:52:52 pm
 */
package com.erian.ict.microgrid.service;

import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.TimeUnit;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.erian.ict.microgrid.domain.DataPointValue;
import com.erian.ict.microgrid.mapper.ConverterMapper;

/**
 * function description：
 *
 * @author <a href="mailto:zhuyb@ntu.edu.sg">Rambo Zhu  </a>
 * @version v 1.0 
 * Create:  25 Oct 2017 7:52:52 pm
 */
public class DataPaser implements Runnable {
    private static  Logger logger = LoggerFactory.getLogger(DataPaser.class);

	final WebsocketClient ws;
	final JSONParser parser = new JSONParser();
	@Autowired
	ConverterMapper mapper;
	
	public DataPaser(final WebsocketClient ws) {
		this.ws = ws;
	}

	@Override
	public void run(){
		if(ws.isConnected()){
			
			logger.info("load data for  - " + ws.deviceId);

			int count = 3;
			try {
				while(count > 0){
					if(ws.message != null){
						final JSONObject json = (JSONObject)parser.parse(ws.message);
						// parse the data
						mapper.storeConvData(json, ws.deviceId);
						
					}else{
							TimeUnit.MILLISECONDS.sleep(600);
							count--;
					}
				}
			
			} catch (InterruptedException | ParseException e) {
				e.printStackTrace();
			}
		}
	}
}