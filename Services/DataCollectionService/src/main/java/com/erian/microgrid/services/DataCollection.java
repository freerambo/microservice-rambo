package com.erian.microgrid.services;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;

public class DataCollection {
public static void main(String[] args) {
		
		try {
			 
			callApiToGetCmdsFromDb();
			Timer timer = new Timer(false); // Instantiate Timer Object
			ScheduledTask st = new ScheduledTask(); // Instantiate SheduledTask class
			timer.schedule(st, 0, 5000); // Create Repetitively task for every 5 seconds
		} 
		catch (Exception e) {
			
			e.printStackTrace();
		}
		
}

	
	
	private static void callApiToGetCmdsFromDb() {
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
					//JSONObject jsonObj = new JSONObject(output);
					
					
					
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
}
