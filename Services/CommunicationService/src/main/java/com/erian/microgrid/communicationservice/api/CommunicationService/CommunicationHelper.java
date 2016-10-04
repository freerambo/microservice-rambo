package com.erian.microgrid.communicationservice.api.CommunicationService;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.simple.JSONObject;

public class CommunicationHelper {
	
	public CommunicationHelper(){
		
		
	}

	public static JSONObject getConnection(String ip, String formattedCommand) throws IOException, InterruptedException{
	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
		Date now = new Date();
		String formattedDate = sdf.format(now);
		System.out.println(formattedDate);
		System.out.println("ip is" + " " + ip + "& command is " + " " +formattedCommand );
		String feedback = createSocketConnection(ip,formattedCommand);
		System.out.println("data received is:" + " "+ feedback);
		JSONObject obj=new JSONObject();
		obj.put("result",feedback);
		obj.put("timestamp",formattedDate);
		System.out.println(obj);
		return obj;
		
	}
	
	private static String createSocketConnection(String ip, String formattedCommand) throws IOException, InterruptedException{
		Socket myClientSocket = null;
		DataOutputStream os = null;
		BufferedReader br =null;
		int PORT = 4001;
		byte[] byteCommand= formattedCommand.getBytes();
		System.out.println(byteCommand);
		try {	
			myClientSocket = new Socket(ip, PORT);
			myClientSocket.setSoTimeout(60000);
			os = new DataOutputStream(myClientSocket.getOutputStream());
			br = new BufferedReader(new InputStreamReader(myClientSocket.getInputStream(), StandardCharsets.UTF_8));
			os.write(byteCommand);
			//Thread.sleep(4000);
			String data= br.readLine();
			System.out.println(data);
			return data;
		}
		
		
		finally{
			os.flush();
			os.close();
			br.close();
			myClientSocket.close();
		}	
		
}
}

