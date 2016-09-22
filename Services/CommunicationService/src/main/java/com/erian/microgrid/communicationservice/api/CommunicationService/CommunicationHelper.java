package com.erian.microgrid.communicationservice.api.CommunicationService;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.simple.JSONObject;

public class CommunicationHelper {
	
	public CommunicationHelper(){
		
		
	}

	public static JSONObject getConnection(String ip, String formattedCommand) throws IOException{

		System.out.println("ip is" + " " + ip + "& command is " + " " +formattedCommand );
		String feedback = createSocketConnection(ip,formattedCommand);
		System.out.println("data received is:" + " "+ feedback);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy h:mm:ss a");
		String formattedDate = sdf.format(date);
		System.out.println(formattedDate);
		JSONObject obj=new JSONObject();
		JSONObject.toString("result",feedback);
		JSONObject.toString("timestamp",formattedDate);
		System.out.println(obj);
		return obj;
		
	}
	
	private static String createSocketConnection(String ip, String formattedCommand) throws IOException{
		Socket myClientSocket = null;
		DataOutputStream os = null;
		BufferedReader br =null;
		int PORT = 4001;
		byte[] byteCommand= formattedCommand.getBytes();
		try {	
			myClientSocket = new Socket(ip, PORT);
			myClientSocket.setSoTimeout(60000);
			os = new DataOutputStream(myClientSocket.getOutputStream());
			br = new BufferedReader(new InputStreamReader(myClientSocket.getInputStream(), "UTF-8"));
			os.write(byteCommand);
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

