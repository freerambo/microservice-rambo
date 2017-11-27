package com.erian.microgrid.services;
import java.util.*;


public class DataCollection {
	
	public static void main(String[] args) {
		
		try {
			System.out.println("-----Starting data-collection service-----");
			Timer timer = new Timer(false); // Instantiate Timer Object
			ScheduledTask st = new ScheduledTask(); // Instantiate SheduledTask class
			timer.schedule(st, 0, 10000); // Create Repetitively task for every 30 seconds
		} 
		catch (Exception e) {
			
			e.printStackTrace();
		}
		
	}
	
	
}
