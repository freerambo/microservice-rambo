package com.erian.microgrid.services;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.TimerTask;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.ParseException;


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
		//JSONArray array = new JSONArray();
		
		try{
			URL url = new URL("http://172.21.76.189/MicrogridApi/devices/commands/read");
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
						//String[] variableNames= (String[]) objects.get("variableNames");
						String ip = (String) objects.get("IPAdress");
						String command = (String) objects.get("commandFormatString");
						System.out.println(ip);
						System.out.println(command);
						callCommunicationApi(ip,command);
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

	private static void callCommunicationApi(String ip, String command) {
		try{
			String cmd = URLEncoder.encode(command, "UTF-8");
			System.out.println(cmd);
			URL url = new URL("http://localhost:8181/CommunicationService/Data/"+ ip +"/"+ cmd);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", "application/json");
			if (conn.getResponseCode() != 200) 
				{
				throw new RuntimeException("Failed : HTTP error code : "
						+ conn.getResponseCode());
				}
			BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
			String commoutput;
			
			System.out.println("Output from Server .... \n");
			while ((commoutput = br.readLine()) != null) {
					System.out.println(commoutput);
					
					}	
			}
		catch (MalformedURLException e) {

			e.printStackTrace();

		  } 
		catch (IOException e) {

			e.printStackTrace();

	}
		}
}