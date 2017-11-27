package com.erian.microgrid.services;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.TimerTask;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.ParseException;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;


public class ScheduledTask extends TimerTask {

	//method to execute the scheduled task
	@Override
	public void run() {
		
		try {
			callApiToGetCmdsFromDb();
			} 
			catch (ParseException e) {
			e.printStackTrace();
		}
		
			}
	
	private static void callApiToGetCmdsFromDb() throws ParseException {
		
		
		try{
			URL url = new URL("http://172.21.76.125:8080/MicrogridApiDev/devices/commands/read");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", "application/json");
			if (conn.getResponseCode() != 200) 
				{
				throw new RuntimeException("Failed : HTTP error code : "
						+ conn.getResponseCode());
				}
			BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
			String output;
			
			System.out.println("Output from Server .... \n");
			while ((output = br.readLine()) != null) {
					System.out.println(output);
					Object obj=JSONValue.parse(output);
					JSONArray array=(JSONArray)obj;
					System.out.println(array.size());
					for (int i=0;i<array.size();i++){
						JSONObject objects =(JSONObject)array.get(i);
						String ip = (String) objects.get("IPAdress");
						String protocolName = (String) objects.get("protocolName");
						String commandTypeName = (String) objects.get("commandTypeName");
						String command = (String) objects.get("commandFormatString");
						System.out.println(objects.get("variableIds"));
						JSONArray variableIds= (JSONArray) objects.get("variableIds");
						System.out.println(ip);
						System.out.println(protocolName);
						System.out.println(command);
						System.out.println(commandTypeName);
						System.out.println(variableIds.toArray());
						System.out.println(variableIds);
						String[] stringarray = (String[]) variableIds.toArray(new String [variableIds.size()]);
						if (commandTypeName.equalsIgnoreCase("Read") & protocolName.equalsIgnoreCase("TCP/IP")){
							callCommunicationApi(ip,command,stringarray);
						}
						else if (commandTypeName.equalsIgnoreCase("Read") & protocolName.equalsIgnoreCase("Web Socket")){
							callWebsocketApi(command,stringarray);
						}
							
						
					}
					
						}
					
			conn.disconnect();
			}
			catch (MalformedURLException e) {

					e.printStackTrace();

				  } 
			catch (IOException e) {

					e.printStackTrace();

			}	
	}

	private static void callWebsocketApi(String command,String[] variableIds) {
		try{
			System.out.println("Calling websocketapi");
			String wscmd = URLEncoder.encode(command, "UTF-8");
			System.out.println(wscmd);
			URL wsurl = new URL("http://localhost:8181/WebSocketCommunication/converterdata/query?command="+wscmd);
			HttpURLConnection conn = (HttpURLConnection) wsurl.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", "application/json");
			BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
			String wsoutput;
			System.out.println("Output from Server .... \n");
			String resultArray[] = null;
			String timestampvalue =null;
			ArrayList<String> list = new ArrayList<String>();
			while ((wsoutput = br.readLine()) != null) {
				System.out.println(wsoutput);
				Object obj=JSONValue.parse(wsoutput);
				JSONObject jobject=(JSONObject)obj;
				System.out.println(jobject.get("result"));
				JSONArray jsonArray = (JSONArray)jobject.get("result");
				//resultArray=(String[]) jobject.get("result");
				for (int i=0;i<jsonArray.size();i++){
					list.add(jsonArray.get(i).toString());
				}
				System.out.println(list);
				//String resultant= (String) jobject.get("result");
				timestampvalue= (String) jobject.get("timestamp");
				System.out.println(list.get(0));
//				}
				JSONObject jsonObject = new JSONObject();
				for (int i=0;i<variableIds.length;i++){
				 jsonObject.put("variableId", variableIds[i]);
				 jsonObject.put("timestamp", timestampvalue );
				 jsonObject.put("value", list.get(i));
				 callDataService(jsonObject);
				}
 	}
		}
		
		catch (MalformedURLException e) {

			e.printStackTrace();

		} 
		catch (IOException e) {

			e.printStackTrace();

		}
			
			
		}
		
	

	private static void callCommunicationApi(String ip, String command, String[] variableIds) {
		try{
			if (ip.equalsIgnoreCase("192.168.127.121")){
				System.out.println("calling communicationapi");
				String cmd = URLEncoder.encode(command, "UTF-8");
				System.out.println(cmd);
				URL url = new URL("http://localhost:8181/CommunicationService/devicedata/"+ ip +"/"+ cmd);
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("GET");
				conn.setRequestProperty("Accept", "application/json");
				//			if (conn.getResponseCode() != 200) 
				//				{
				//				throw new RuntimeException("Failed : HTTP error code : "
				//						+ conn.getResponseCode());
				//				}
				BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
				String commoutput;
				System.out.println("Output from Server .... \n");
				String resultArray[] = null;
				String timestampvalue =null;
				while ((commoutput = br.readLine()) != null) {
					System.out.println(commoutput);
					Object obj=JSONValue.parse(commoutput);
					JSONObject jobject=(JSONObject)obj;
					System.out.println(jobject.get("result"));
					String resultant= (String) jobject.get("result");
					timestampvalue= (String) jobject.get("timestamp");
					resultArray= resultant.split(";");
					}
				JSONObject jsonObject = new JSONObject();
				for (int i=0;i<variableIds.length;i++){
					//jsonObject.put(variableIds[i], resultArray[i]);
					jsonObject.put("variableId", variableIds[i]);
					jsonObject.put("timestamp", timestampvalue );
					jsonObject.put("value", resultArray[i]);
					callDataService(jsonObject);
			}
			}
			else{
				System.out.println(ip + "This device is not connected");
			}
		}
		catch (MalformedURLException e) {

			e.printStackTrace();

		  } 
		catch (IOException e) {

			e.printStackTrace();

	}
		}
	
	

	private static void callDataService(JSONObject jsonobject) {
		try{
			System.out.println("Calling data service....");

			Client client = Client.create();
			WebResource webResource = client.resource("http://172.21.76.125:8080/MicrogridApiDev/data");
		    System.out.println(jsonobject.toString());
		    String input= jsonobject.toString();
		    // POST method call
		    ClientResponse response = webResource.accept("application/json").type("application/json").post(ClientResponse.class,input);
		    // check response status code
		    if (response.getStatus() != 200) {
		            throw new RuntimeException("Failed : HTTP error code : "
		                    + response.getStatus());
		        }

		     // display response
		     String output = response.getEntity(String.class);
		     System.out.println("Output from Server .... ");
		     System.out.println(output + "\n");
		}	
		catch (Exception e) {
			
			e.printStackTrace();
			
		}
	}
}