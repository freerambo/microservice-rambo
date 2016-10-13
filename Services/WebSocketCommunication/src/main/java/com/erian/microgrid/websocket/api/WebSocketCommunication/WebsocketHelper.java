package com.erian.microgrid.websocket.api.WebSocketCommunication;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;


public class WebsocketHelper {
	
	public static WebsocketClient wsc;
	public WebsocketHelper() {
		
	    }

	 public static JSONObject Start(String command) throws InterruptedException, IOException, ParseException {
		 	//System.out.println(command);
	        wsc = new WebsocketClient();
	        wsc.Connect(command);
	        //wsc.Connect("ws://192.168.127.13:8888/battery/con");
	        Thread.sleep(1000);
	        wsc.Disconnect();
	        String data = wsc.message;
	        System.out.println(data);
	        JSONObject jobj = (JSONObject) new JSONParser().parse(data);
	        //System.out.println(jobj);
	        //System.out.println(jobj.values());
	        ArrayList<String> ar = new ArrayList<String>();
	        for(Iterator iterator = jobj.keySet().iterator(); iterator.hasNext();) {
	            String key = (String) iterator.next();
	            //System.out.println(jobj.get(key).toString());
	            String arr = jobj.get(key).toString();
	            ar.add(arr);
	        }
	       //System.out.println(ar);
//	       StringBuilder listString = new StringBuilder();
//	       for (String s : ar)
//	            listString.append(s+",");
//	       System.out.println(listString);
//	       System.out.println(ar.get(0));
	       SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
	       Date now = new Date();
	       String formattedDate = sdf.format(now);
	       System.out.println(formattedDate);
	       JSONObject ob = new JSONObject();
	       ob.put("result", ar);
	       ob.put("timestamp", formattedDate);
	       System.out.println(ob);
	       return ob;
			
	
	    }


//	  public static void main(String[] args) throws InterruptedException, IOException 
//	    {
//	    	WebsocketHelper wh = new WebsocketHelper();
//	        wh.Start();
//	        Thread.sleep(1000);
//	    }

	}    

	          
	         
		

	
	
	


