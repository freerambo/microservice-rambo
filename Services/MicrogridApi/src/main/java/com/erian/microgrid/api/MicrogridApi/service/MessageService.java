package com.erian.microgrid.api.MicrogridApi.service;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.erian.microgrid.api.MicrogridApi.service.DatabaseHelper;
import com.erian.microgrid.api.MicrogridApi.model.Device;
import com.erian.microgrid.api.MicrogridApi.model.Device1;


public class MessageService {

	public List<Device> getAllDevices(){
		List<Device> list = new ArrayList<>();
		Connection c = null;
		try {
	            c = DatabaseHelper.getConnection();
	            Statement s = c.createStatement();
	            String sql = "{call get_devices ()}";
	            ResultSet rs = s.executeQuery(sql);
	            while (rs.next()) {
	                list.add(processSummaryRow(rs));
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            throw new RuntimeException(e);
			} finally {
				DatabaseHelper.close(c);
			}
	        return list;
	    }
	
	
	protected Device processSummaryRow(ResultSet rs) throws SQLException {
    	Device device = new Device();
    	device.setID(rs.getInt("ID"));
    	device.setTypeID(rs.getInt("TypeID"));
    	device.setTypeName(rs.getString("TypeName"));
    	device.setClassID(rs.getInt("ClassID"));
    	device.setClassName(rs.getString("ClassName"));
    	device.setName(rs.getString("Name"));
    	device.setDescription(rs.getString("Description"));
    	device.setMicrogridID(rs.getInt("MicrogridID"));
    	device.setMicrogridName(rs.getString("MicrogridName"));
    	device.setVendor(rs.getString("Vendor"));
    	device.setModel(rs.getString("Model"));
    	device.setLocation(rs.getString("Location"));
    	device.setIPAdress(rs.getString("IPAdress"));
    	device.setPortNumber(rs.getString("PortNumber"));
    	device.setBusID(rs.getInt("BusID"));
    	device.setIsProgrammable(rs.getInt("IsProgrammable"));
    	device.setIsConnected(rs.getInt("IsConnected"));
    	
    	return device;
   }

   public Device1 addNewDevice(Device1 device1) {
	   
	   Connection c = null;
	   //ResultSet rs;
	   PreparedStatement ps=null;
	   try {
		   c = DatabaseHelper.getConnection();
		   String query = "{call add_device(?,?,?,?,?,?,?,?,?,?,?,?)}";
		   ps= c.prepareStatement(query);
		   ps.setInt(1, device1.getTypeID());
		   ps.setString(2, device1.getName());
		   ps.setString(3, device1.getDescription());
		   ps.setInt(4, device1.getMicrogridID());
		   ps.setString(5, device1.getVendor());
		   ps.setString(6, device1.getModel());
		   ps.setString(7, device1.getLocation());
		   ps.setString(8, device1.getIPAdress());
		   ps.setString(9, device1.getPortNumber());
		   ps.setInt(10, device1.getBusID());
		   ps.setInt(11, device1.getIsProgrammable());
		   ps.setInt(12, device1.getIsConnected());
		   ps.executeQuery();
		   

	   }
           catch (Exception e) {
               e.printStackTrace();
               throw new RuntimeException(e);
               
   		} finally {
   			DatabaseHelper.close(c);
   		}
           return device1;
		   }
   }
	
	



