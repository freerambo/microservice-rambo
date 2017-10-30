package com.erian.ict.microgrid.service;

import com.erian.ict.microgrid.domain.*;
import com.erian.ict.microgrid.mapper.ConverterMapper;
import com.google.common.collect.Maps;

import org.apache.commons.io.FileUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import javax.annotation.PostConstruct;
import javax.websocket.CloseReason;

import java.io.File;
import java.io.FileReader;
import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import com.erian.ict.microgrid.domain.*;
import com.erian.ict.microgrid.domain.model.*;

/**
 * Created by nhdevika on 2/14/2017.
 */

@Component
public class ConverterService {

    static Set<WebSocketSession> sessions = Collections.synchronizedSet(new HashSet<>());

    private static final String FILENAME = "C:/Users/icterian/git/AllConvertersMicroservice/src/main/resources/config/converter.json";
    
    private static  Logger logger = LoggerFactory.getLogger(ConverterService.class);

    public static WebsocketClient wsBatteryOne;

    public static WebsocketClient wsBatteryTwo;

    public static WebsocketClient wsBICOne;

    public static WebsocketClient wsBICTwo;

    public static WebsocketClient wsPVOne;
 
    public static WebsocketClient wsPVTwo;
    
    public static final Map<String, WebsocketClient> wsClients = Maps.newHashMap();

    public static JSONObject configJson;

    @Autowired
    ConverterMapper mapper;
    
    public ConverterService() {
		configJson = loadDeviceConfiguration();
		wsBatteryOne = this.getWebSocketClient("battery1");
		wsBatteryTwo = this.getWebSocketClient("battery2");
		wsBICOne =this.getWebSocketClient("bic1");
		wsBICTwo = this.getWebSocketClient("bic2");
		wsPVOne =this.getWebSocketClient("pv1");
		wsPVTwo = this.getWebSocketClient("pv2");
		storeConvertersData();
    }

    public WebsocketClient getWebSocketClient(String deviceId){
    	WebsocketClient client = wsClients.get(deviceId);
    	if(client == null){
    		String url = (String)((JSONObject)configJson.get(deviceId)).get("uri");
    		client = new WebsocketClient(url,deviceId);
    		wsClients.put(deviceId, client);
    	}
    	return client;
    }
    
    
    public void addSession(WebSocketSession session) {
        sessions.add(session);
    }

    public void removeSession(WebSocketSession session) {
        sessions.remove(session);
    }

    public void sendToAll(JSONObject jsonObject) {
        for (WebSocketSession session : sessions) {
            try {
                session.sendMessage(new TextMessage(jsonObject.toJSONString()));
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }

    private JSONObject loadDeviceConfiguration() {
        JSONParser parser = new JSONParser();
        JSONObject configJson = new JSONObject();
        try {
        	String file = FileUtils.readFileToString(new File(FILENAME));
        	
            configJson = (JSONObject) parser.parse(file);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return configJson;
    }

    @Scheduled(fixedDelay = 1000)
    public void getAllConverterData() {
        JSONObject jsonAll = new JSONObject();
        JSONArray array  = new JSONArray();
        try {
            JSONParser parser = new JSONParser();

            if (wsBatteryOne.message != null) {
                JSONObject batteryOneJson = (JSONObject)parser.parse(wsBatteryOne.message);
                batteryOneJson.put("deviceId",wsBatteryOne.deviceId);
                array.add(batteryOneJson);
            }

            if (wsBatteryTwo.message != null) {
                JSONObject batteryTwoJson = (JSONObject)parser.parse(wsBatteryTwo.message);
                batteryTwoJson.put("deviceId",wsBatteryTwo.deviceId);
                array.add(batteryTwoJson);
            }

            if (wsBICOne.message != null) {
                JSONObject bicOneJson = (JSONObject)parser.parse(wsBICOne.message);
                bicOneJson.put("deviceId", wsBICOne.deviceId);
                array.add(bicOneJson);
            }

            if (wsBICTwo.message != null) {
                JSONObject bicTwoJson = (JSONObject)parser.parse(wsBICTwo.message);
                bicTwoJson.put("deviceId",wsBICTwo.deviceId);
                array.add(bicTwoJson);
            }

            if (wsPVOne.message != null) {
                JSONObject pcOneJson = (JSONObject)parser.parse(wsPVOne.message);
                pcOneJson.put("deviceId",wsPVOne.deviceId);
                array.add(pcOneJson);

            }
            if (wsPVTwo.message != null) {
                JSONObject pcTwoJson = (JSONObject)parser.parse(wsPVTwo.message);
                pcTwoJson.put("deviceId",wsPVTwo.deviceId);
                array.add(pcTwoJson);
            }
            
            if (array.size() == 0) {
                jsonAll.put("message", "ERROR");
                jsonAll.put("alert","Connected to WS but no data");
            } else {
                jsonAll.put("converters",array);
            }
            sendToAll(jsonAll);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

//	static final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(10);
	
	@Scheduled(initialDelay=6000, fixedRate = 60000)
    public void storeConvertersData() {
	    	for (String key : wsClients.keySet()){
	    		final WebsocketClient ws = wsClients.get(key);
	    		if(ws.isConnected()){
	    			logger.info("storeConvertersData for " + ws.deviceId);
//	    			scheduler.scheduleAtFixedRate(new DataPaser(ws), 10000, 60000, TimeUnit.MILLISECONDS);
	    			new DataPaser(ws,mapper).start();
	    		}
	    	}
    }

    public JSONObject getConverterData(String deviceId) {
        JSONParser parser = new JSONParser();
        JSONObject converterJson = new JSONObject();
        try {
            if ((wsPVOne.deviceId).equals(deviceId)) {
                if (wsPVOne.message != null) {
                    converterJson = (JSONObject)parser.parse(wsPVOne.message);
                    converterJson.put("deviceId", wsPVOne.deviceId);
                } else {
                    if (wsPVOne.userSession != null) {
                        converterJson.put("message", "ERROR");
                        converterJson.put("alert","Connected to Converter but no data");
                    } else {
                        converterJson.put("message", "ERROR");
                        converterJson.put("alert","Cannot establish websocket connection to the converter");
                    }
                }
            } else if ((wsPVTwo.deviceId).equals(deviceId)) {
                if (wsPVTwo.message != null) {
                    converterJson = (JSONObject)parser.parse(wsPVTwo.message);
                    converterJson.put("deviceId", wsPVTwo.deviceId);
                } else {
                    if (wsPVTwo.userSession != null) {
                        converterJson.put("message", "ERROR");
                        converterJson.put("alert","Connected to Converter but no data");
                    } else {
                        converterJson.put("message", "ERROR");
                        converterJson.put("alert","Cannot establish websocket connection to the converter");
                    }
                }

            } else if ((wsBatteryOne.deviceId).equals(deviceId)) {
                if (wsBatteryOne.message != null) {
                    converterJson = (JSONObject)parser.parse(wsBatteryOne.message);
                    converterJson.put("deviceId", wsBatteryOne.deviceId);
                } else {
                    if (wsBatteryOne.userSession != null) {
                        converterJson.put("message", "ERROR");
                        converterJson.put("alert","Connected to Converter but no data");
                    } else {
                        converterJson.put("message", "ERROR");
                        converterJson.put("alert","Cannot establish websocket connection to the converter");
                    }
                }

            } else if ((wsBatteryTwo.deviceId).equals(deviceId)) {
                if (wsBatteryTwo.message != null) {
                    converterJson = (JSONObject)parser.parse(wsBatteryTwo.message);
                    converterJson.put("deviceId",wsBatteryTwo.deviceId);
                } else {
                    if (wsBatteryTwo.userSession != null) {
                        converterJson.put("message", "ERROR");
                        converterJson.put("alert","Connected to Converter but no data");
                    } else {
                        converterJson.put("message", "ERROR");
                        converterJson.put("alert","Cannot establish websocket connection to the converter");
                    }
                }

            } else if ((wsBICOne.deviceId).equals(deviceId)) {
                if (wsBICOne.message != null) {
                    converterJson = (JSONObject)parser.parse(wsBICOne.message);
                    converterJson.put("deviceId", wsBICOne.deviceId);
                } else {
                    if (wsBICOne.userSession != null) {
                        converterJson.put("message", "ERROR");
                        converterJson.put("alert","Connected to Converter but no data");
                    } else {
                        converterJson.put("message", "ERROR");
                        converterJson.put("alert","Cannot establish websocket connection to the converter");
                    }
                }

            } else if ((wsBICTwo.deviceId).equals(deviceId)) {
                if (wsBICTwo.message != null) {
                    converterJson = (JSONObject)parser.parse(wsBICTwo.message);
                    converterJson.put("deviceId", wsBICTwo.deviceId);
                } else {
                    if (wsBICTwo.userSession != null) {
                        converterJson.put("message", "ERROR");
                        converterJson.put("alert","Connected to Converter but no data");
                    } else {
                        converterJson.put("message", "ERROR");
                        converterJson.put("alert","Cannot establish websocket connection to the converter");
                    }
                }
            }
        } catch (Exception e) {
            converterJson.put("message", "ERROR");
            converterJson.put("alert", "Exception: "+ e.getMessage());
        }
        return converterJson;
    }

    public JSONObject setBatteryConverterDroopControl(String deviceId, JSONObject setvalues) {
        JSONObject jsonObject = new JSONObject();
        JSONParser parser = new JSONParser();
        JSONObject request = new JSONObject();

        try {
            System.out.println(deviceId+setvalues.toJSONString());
            request.put("cmd", "DROOP_CONTROL_TURN_ON");
            request.put("parameters", setvalues);
            WebsocketClient websocketClient = this.getWebSocketClient(deviceId);
            websocketClient.sendMessage(request.toString());
            Thread.sleep(2000);
            if (websocketClient.message != null) {
                jsonObject = (JSONObject)parser.parse(websocketClient.message);
            } else {
                if (websocketClient.userSession != null) {
                    jsonObject.put("message", "ERROR");
                    jsonObject.put("alert","Connected to Converter but no data");
                } else {
                    jsonObject.put("message", "ERROR");
                    jsonObject.put("alert","Cannot establish websocket connection to the converter");
                }
            }

        } catch (Exception e) {
            jsonObject.put("message", "ERROR");
            jsonObject.put("alert", "Exception: "+ e.getMessage());

        }
        return jsonObject;
    }

    public JSONObject setBatteryConverterPowerControl(String deviceId, JSONObject setvalues) {
        JSONObject jsonObject = new JSONObject();
        JSONParser parser = new JSONParser();
        JSONObject request = new JSONObject();

        try {

            request.put("cmd","POWER_CONTROL_TURN_ON");
            request.put("parameters",setvalues);
            WebsocketClient websocketClient = this.getWebSocketClient(deviceId);
            websocketClient.sendMessage(request.toString());
            Thread.sleep(2000);
            if (websocketClient.message != null) {
                jsonObject = (JSONObject)parser.parse(websocketClient.message);
            } else {
                if (websocketClient.userSession != null) {
                    jsonObject.put("message", "ERROR");
                    jsonObject.put("alert","Connected to Converter but no data");
                } else {
                    jsonObject.put("message", "ERROR");
                    jsonObject.put("alert","Cannot establish websocket connection to the converter");
                }
            }
//            websocketClient.onClose(websocketClient.userSession,new CloseReason(CloseReason.CloseCodes.NORMAL_CLOSURE, "Normal close"));

        } catch (Exception e) {
            jsonObject.put("message", "ERROR");
            jsonObject.put("alert", "Exception: "+ e.getMessage());
        }
        return jsonObject;
    }

    public JSONObject setBatteryConverterOff(String deviceId) {
        JSONObject request = new JSONObject();
        JSONObject response = new JSONObject();
        try {
            request.put("cmd", "TURN_OFF");
            request.put("parameters", new JSONObject());
//            WebsocketClient websocketClient = new WebsocketClient((String)((JSONObject)configJson.get(deviceId)).get("uri"),(String)((JSONObject)configJson.get(deviceId)).get("deviceId"));
            WebsocketClient websocketClient = this.getWebSocketClient(deviceId);

            websocketClient.sendMessage(request.toString());
//            websocketClient.onClose(websocketClient.userSession,new CloseReason(CloseReason.CloseCodes.NORMAL_CLOSURE, "Normal close"));
        } catch (Exception e) {
            response.put("message", "ERROR");
            response.put("alert", "Exception: "+ e.getMessage());
        }
        return response;
    }

    public JSONObject setBICConverterRectifier(String deviceId, JSONObject setvalues) {
        JSONObject jsonObject = new JSONObject();
        JSONParser parser = new JSONParser();
        JSONObject request = new JSONObject();

        try {
            request.put("cmd", "TURN_ON_RECTIFIER");
            request.put("parameters", setvalues);
            WebsocketClient websocketClient = this.getWebSocketClient(deviceId);

            websocketClient.sendMessage(request.toString());
            Thread.sleep(2000);
            if (websocketClient.message != null) {
                jsonObject = (JSONObject)parser.parse(websocketClient.message);
            } else {
                if (websocketClient.userSession != null) {
                    jsonObject.put("message", "ERROR");
                    jsonObject.put("alert","Connected to Converter but no data");
                } else {
                    jsonObject.put("message", "ERROR");
                    jsonObject.put("alert","Cannot establish websocket connection to the converter");
                }
            }
        } catch (Exception e) {
            jsonObject.put("message", "ERROR");
            jsonObject.put("alert", "Exception: "+ e.getMessage());
        }
        return jsonObject;
    }

    public JSONObject setBICConverterInverter(String deviceId, JSONObject setvalues) {
        JSONObject jsonObject = new JSONObject();
        JSONObject request = new JSONObject();
        JSONParser parser = new JSONParser();

        try {
            request.put("cmd", "TURN_ON_INVERTER");
            request.put("parameters", setvalues);
            WebsocketClient websocketClient = this.getWebSocketClient(deviceId);

            websocketClient.sendMessage(request.toString());
            Thread.sleep(2000);
            if (websocketClient.message != null) {
                jsonObject = (JSONObject)parser.parse(websocketClient.message);
            } else {
                if (websocketClient.userSession != null) {
                    jsonObject.put("message", "ERROR");
                    jsonObject.put("alert","Connected to Converter but no data");
                } else {
                    jsonObject.put("message", "ERROR");
                    jsonObject.put("alert","Cannot establish websocket connection to the converter");
                }
            }
        } catch (Exception e) {
            jsonObject.put("message", "ERROR");
            jsonObject.put("alert", "Exception: "+ e.getMessage());
        }
        return jsonObject;
    }

    public JSONObject setBICConverterPowerDispatch(String deviceId, JSONObject setvalues) {
        JSONObject jsonObject = new JSONObject();
        JSONObject request = new JSONObject();
        JSONParser parser = new JSONParser();

        try {

            request.put("cmd", "TURN_ON_POWER_DISPATCH");
            request.put("parameters", setvalues);
            WebsocketClient websocketClient = this.getWebSocketClient(deviceId);

            websocketClient.sendMessage(request.toString());

            Thread.sleep(2000);
            if (websocketClient.message != null) {
                jsonObject = (JSONObject)parser.parse(websocketClient.message);
            } else {
                if (websocketClient.userSession != null) {
                    jsonObject.put("message", "ERROR");
                    jsonObject.put("alert","Connected to Converter but no data");
                } else {
                    jsonObject.put("message", "ERROR");
                    jsonObject.put("alert","Cannot establish websocket connection to the converter");
                }
            }

        } catch (Exception e) {
            jsonObject.put("message", "ERROR");
            jsonObject.put("alert", "Exception: "+ e.getMessage());
        }
        return jsonObject;

    }

    public JSONObject setBICConverterOff(String deviceId) {
        JSONObject request = new JSONObject();
        JSONObject jsonObject = new JSONObject();
        try {

            request.put("cmd", "TURN_OFF");
            request.put("parameters", new JSONObject());

            WebsocketClient websocketClient = this.getWebSocketClient(deviceId);

            websocketClient.sendMessage(request.toString());


        } catch (Exception e) {
            jsonObject.put("message", "ERROR");
            jsonObject.put("alert", "Exception: "+ e.getMessage());
        }
        return jsonObject;
    }

    public JSONObject setPVConverterMPPT(String deviceId, String command) {
        JSONObject request = new JSONObject();
        JSONObject jsonObject = new JSONObject();
        try {

            request.put("cmd", command);
            request.put("parameters", new JSONObject());
            System.out.println(request.toJSONString());
            WebsocketClient websocketClient = this.getWebSocketClient(deviceId);

            websocketClient.sendMessage(request.toString());


        } catch (Exception e) {
            jsonObject.put("message", "ERROR");
            jsonObject.put("alert", "Exception: "+ e.getMessage());
        }
        return jsonObject;
    }

    public JSONObject setPVConverterChannelOff(String deviceId, String command) {
        JSONObject request = new JSONObject();
        JSONObject jsonObject = new JSONObject();
        try {

            request.put("cmd", command);
            request.put("parameters", new JSONObject());
            System.out.println(request.toJSONString());

            WebsocketClient websocketClient = this.getWebSocketClient(deviceId);

            websocketClient.sendMessage(request.toString());


        } catch (Exception e) {
            jsonObject.put("message", "ERROR");
            jsonObject.put("alert", "Exception: "+ e.getMessage());
        }
        return jsonObject;
    }

    public JSONObject setPVConverterPowerDispatch(String deviceId, JSONObject setvalues, String command) {
        JSONObject jsonObject = new JSONObject();
        JSONObject request = new JSONObject();
        JSONParser parser = new JSONParser();

        try {

            request.put("cmd", command);
            request.put("parameters", setvalues);
            System.out.println(request.toJSONString());
            WebsocketClient websocketClient = this.getWebSocketClient(deviceId);
            websocketClient.sendMessage(request.toString());

            Thread.sleep(2000);
            if (websocketClient.message != null) {
                jsonObject = (JSONObject)parser.parse(websocketClient.message);
            } else {
                if (websocketClient.userSession != null) {
                    jsonObject.put("message", "ERROR");
                    jsonObject.put("alert","Connected to Converter but no data");
                } else {
                    jsonObject.put("message", "ERROR");
                    jsonObject.put("alert","Cannot establish websocket connection to the converter");
                }
            }

        } catch (Exception e) {
            jsonObject.put("message", "ERROR");
            jsonObject.put("alert", "Exception: "+ e.getMessage());
        }
        return jsonObject;

    }

    public JSONObject setConverterStatus(String deviceId, String command) {
    	JSONObject request = new JSONObject();
        JSONObject jsonObject = new JSONObject();
        try {

            request.put("cmd", command);
            request.put("parameters", new JSONObject());
            System.out.println(request.toJSONString());
            WebsocketClient websocketClient = this.getWebSocketClient(deviceId);
            websocketClient.sendMessage(request.toString());


        } catch (Exception e) {
            jsonObject.put("message", "ERROR");
            jsonObject.put("alert", "Exception: "+ e.getMessage());
        }
        return jsonObject;
    }
    
    public JSONObject setIsolateForDevice(String deviceId, String command) {
    	JSONObject request = new JSONObject();
        JSONObject jsonObject = new JSONObject();
        try {
            request.put("cmd", command);
            request.put("parameters", new JSONObject());
            System.out.println(request.toJSONString());
            WebsocketClient websocketClient = this.getWebSocketClient(deviceId);
            websocketClient.sendMessage(request.toString());

        } catch (Exception e) {
            jsonObject.put("message", "ERROR");
            jsonObject.put("alert", "Exception: "+ e.getMessage());
        }
        return jsonObject;
    }
    
    @Scheduled(initialDelay=3000, fixedRate = 4000)
    public void checkClients(){
    	for (String key : wsClients.keySet()){
/*    		if(!wsClients.get(key).isConnected()){
    			logger.warn(key + " is closed but we tried to reconnect!! ");
    		}*/
    		logger.info("Check the connectivity of " + key);
    		wsClients.get(key).isConnected(true);
    	}
    }
    
    
    
}
