package com.erian.microgrid.api.MicrogridApi.service;
import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceData;
import com.erian.microgrid.api.MicrogridApi.model.Device;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.erian.microgrid.api.MicrogridApi.service.DatabaseHelper;
import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceData;
import com.erian.microgrid.api.MicrogridApi.model.Device;

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


}

