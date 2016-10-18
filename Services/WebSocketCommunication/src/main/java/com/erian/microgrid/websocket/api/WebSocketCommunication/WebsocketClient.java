package com.erian.microgrid.websocket.api.WebSocketCommunication;	
	
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

import javax.websocket.ClientEndpoint;
import javax.websocket.CloseReason;
import javax.websocket.ContainerProvider;
import javax.websocket.DeploymentException;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.WebSocketContainer;


@ClientEndpoint
public class WebsocketClient {
	
	    protected   WebSocketContainer container;
	    protected   Session userSession = null;
	    public String message;
		

	    public WebsocketClient() {
	        container = ContainerProvider.getWebSocketContainer();
	    }

	    public void Connect(String sServer) {

	          try {
	              userSession = container.connectToServer(this, new URI(sServer));
	              

	            } catch (DeploymentException | URISyntaxException | IOException e) {
	                e.printStackTrace();
	            }

	    }

//	    public void SendMessage(String sMsg) throws IOException {
//	        userSession.getBasicRemote().sendText(sMsg);
//	    }

	    @OnOpen
	    public void onOpen(Session session) {
	        System.out.println("Connected");
	    }

	    @OnClose
	    public void onClose(Session session, CloseReason closeReason) {
	    	System.out.println("Disconnected");
	    }

	    @OnMessage
	    public void onMessage(Session session, String msg) {
	        System.out.println(msg);
	        //System.out.println(msg.getClass().getName());
	        message = msg;
			
	    }

	    public void Disconnect() throws IOException {
	        userSession.close();
	    }
	}



