package com.erian.microgrid.api.MicrogridApi.service;
import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceData;
import com.erian.microgrid.api.MicrogridApi.model.Device;
import com.erian.microgrid.api.MicrogridApi.model.Device1;
import com.erian.microgrid.api.MicrogridApi.service.DatabaseHelper;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


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
	                list.add(Mapper.MapDevice(processSummaryRow(rs)));
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            throw new RuntimeException(e);
			} finally {
				DatabaseHelper.close(c);
			}
	        return list;
	    }


	protected DeviceData processSummaryRow(ResultSet rs) throws SQLException {
    	DeviceData  deviceData = new DeviceData();
    	deviceData.setID(rs.getInt("ID"));
    	deviceData.setTypeID(rs.getInt("TypeID"));
    	deviceData.setTypeName(rs.getString("TypeName"));
    	deviceData.setClassID(rs.getInt("ClassID"));
    	deviceData.setClassName(rs.getString("ClassName"));
    	deviceData.setName(rs.getString("Name"));
    	deviceData.setDescription(rs.getString("Description"));
    	deviceData.setMicrogridID(rs.getInt("MicrogridID"));
    	deviceData.setMicrogridName(rs.getString("MicrogridName"));
    	deviceData.setVendor(rs.getString("Vendor"));
    	deviceData.setModel(rs.getString("Model"));
    	deviceData.setLocation(rs.getString("Location"));
    	deviceData.setIPAdress(rs.getString("IPAdress"));
    	deviceData.setPortNumber(rs.getString("PortNumber"));
    	deviceData.setBusID(rs.getInt("BusID"));
    	deviceData.setIsProgrammable(rs.getInt("IsProgrammable"));
    	deviceData.setIsConnected(rs.getInt("IsConnected"));
    	
    	return deviceData;
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

