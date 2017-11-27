package com.erian.microgrid.api.MicrogridApi.service;

import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceData;
import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceValuesData;
import com.erian.microgrid.api.MicrogridApi.model.Device;
import com.erian.microgrid.api.MicrogridApi.model.DeviceDetails;
import com.erian.microgrid.api.MicrogridApi.model.VariableDetails;
import com.mysql.jdbc.StringUtils;

import java.lang.reflect.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.glassfish.jersey.server.internal.JsonWithPaddingInterceptor;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class DeviceHelper {
	// private Connection c = null;

	public static List<Device> GetAllDevices() {
		List<DeviceData> dataList = GetAllDeviceData();
		List<Device> res = new ArrayList<>();
		// TODO - fix 'error: lambda expressions are not supported in -source
		// 1.7' and use lambda-expression instead of loop
		// dataList.forEach( (data) -> res.add(Mapper.MapDevice(data)));
		for (DeviceData data : dataList) {
			res.add(Mapper.MapDevice(data));
		}

		return res;
	}

	public static Device GetDevice(int deviceID) {
		return Mapper.MapDevice(GetDeviceData(deviceID));
	}

	public static Device AddNewDevice(Device newDevice) {
		return Mapper.MapDevice(AddNewDevice(Mapper.MapDevice(newDevice)));
	}

	public static Device UpdateDevice(Device newDevice) {
		return Mapper.MapDevice(UpdateDevice(Mapper.MapDevice(newDevice)));
	}

	protected static List<DeviceData> GetAllDeviceData() {
		List<DeviceData> list = new ArrayList<>();
		Connection c = null;
		try {
			c = DatabaseHelper.getConnection();
			Statement s = c.createStatement();
			String sql = "{call get_devices ()}";
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
				list.add(processDeviceRow(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			DatabaseHelper.close(c);
		}
		return list;
	}

	protected static DeviceData GetDeviceData(int deviceID) {
		DeviceData res = null;
		Connection c = null;
		try {
			c = DatabaseHelper.getConnection();
			Statement s = c.createStatement();
			String sql = "{call get_device (" + deviceID + ")}";
			ResultSet rs = s.executeQuery(sql);
			rs.next();
			res = processDeviceRow(rs);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			DatabaseHelper.close(c);
		}
		return res;
	}

	protected static DeviceData AddNewDevice(DeviceData newDevice) {
		Connection c = null;
		DeviceData deviceData = new DeviceData();
		PreparedStatement ps = null;
		try {
			c = DatabaseHelper.getConnection();
			String query = "{call add_device(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			ps = c.prepareStatement(query);
			ps.setInt(1, newDevice.getTypeID());
			ps.setString(2, newDevice.getName());
			ps.setString(3, newDevice.getDescription());
			ps.setInt(4, newDevice.getMicrogridID());
			ps.setString(5, newDevice.getVendor());
			ps.setString(6, newDevice.getModel());
			ps.setString(7, newDevice.getLocation());
			ps.setString(8, newDevice.getIPAdress());
			ps.setString(9, newDevice.getPortNumber());
			ps.setInt(10, newDevice.getBusID());
			ps.setInt(11, newDevice.getIsProgrammable());
			ps.setInt(12, newDevice.getIsConnected());
			ps.setString(13, newDevice.getComment());
			ps.setString(14, newDevice.getReadCommand());

			ResultSet rs = ps.executeQuery();

			while (rs.next()) { // Read the inserted device row, the complete
								// data row from DB
				deviceData = processDeviceRow(rs);
				return deviceData;
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);

		} finally {
			DatabaseHelper.close(c);
		}
		return newDevice;
	}

	protected static DeviceData UpdateDevice(DeviceData updDevice) {
		Connection c = null;
		PreparedStatement ps = null;
		DeviceData deviceData = new DeviceData();
		try {
			c = DatabaseHelper.getConnection();
			String query = "{call update_device(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			ps = c.prepareStatement(query);
			ps.setInt(1, updDevice.getID());
			ps.setInt(2, updDevice.getTypeID());
			ps.setString(3, updDevice.getName());
			ps.setString(4, updDevice.getDescription());
			ps.setInt(5, updDevice.getMicrogridID());
			ps.setString(6, updDevice.getVendor());
			ps.setString(7, updDevice.getModel());
			ps.setString(8, updDevice.getLocation());
			ps.setString(9, updDevice.getIPAdress());
			ps.setString(10, updDevice.getPortNumber());
			ps.setInt(11, updDevice.getBusID());
			ps.setInt(12, updDevice.getIsProgrammable());
			ps.setInt(13, updDevice.getIsConnected());
			ps.setString(14, updDevice.getComment()); // add comment
			ps.setString(15, updDevice.getReadCommand()); // we don't send
															// command ID as we
															// recreate it each
															// time

			ResultSet rs = ps.executeQuery();

			while (rs.next()) { // Read the updated device row, the complete
								// data row from DB
				deviceData = processDeviceRow(rs);
				return deviceData;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);

		} finally {
			DatabaseHelper.close(c);
		}
		return null;
	}

	protected static DeviceData processDeviceRow(ResultSet rs) throws SQLException {
		DeviceData deviceData = new DeviceData();
		deviceData.setID(rs.getInt("id"));
		deviceData.setTypeID(rs.getInt("typeID"));
		deviceData.setTypeName(rs.getString("typeName"));
		deviceData.setClassID(rs.getInt("classID"));
		deviceData.setClassName(rs.getString("className"));
		deviceData.setName(rs.getString("name"));
		deviceData.setDescription(rs.getString("description"));
		deviceData.setMicrogridID(rs.getInt("microgridID"));
		deviceData.setMicrogridName(rs.getString("microgridName"));
		deviceData.setVendor(rs.getString("vendor"));
		deviceData.setModel(rs.getString("model"));
		deviceData.setLocation(rs.getString("location"));
		deviceData.setIPAdress(rs.getString("IPAdress"));
		deviceData.setPortNumber(rs.getString("portNumber"));
		deviceData.setBusID(rs.getInt("busID"));
		deviceData.setBusName(rs.getString("busName"));
		deviceData.setIsProgrammable(rs.getInt("isProgrammable"));
		deviceData.setIsConnected(rs.getInt("isConnected"));
		deviceData.setReadCommand(rs.getString("readCommand"));
		deviceData.setReadCommandID(rs.getInt("readCommandId"));
		deviceData.setReadCommandID(rs.getInt("readCommandId"));
		deviceData.setReadCommandID(rs.getInt("readCommandId"));
		deviceData.setComment(rs.getString("comment"));
		System.out.println(rs.getString("comment"));
		return deviceData;
	}

	public static List<DeviceDetails> getAllDevicesDetails() throws ParseException {
		List<DeviceDetails> devtlslist = new ArrayList<>();
		DeviceDetails devicedtls = new DeviceDetails();
		Connection c = null;
		try {
			c = DatabaseHelper.getConnection();
			Statement s = c.createStatement();
			String sql = "{call get_devices_data_latest ()}";
			ResultSet result = s.executeQuery(sql);

			ResultSetMetaData rsmd = result.getMetaData();
			int columnNumber = rsmd.getColumnCount();
			while (result.next()) {
				for (int i = 1; i <= columnNumber; i++) {

					JSONParser parser = new JSONParser();
					JSONObject jsondevdtl = (JSONObject) parser.parse(result.getString(i));
					// System.out.println(jsondevdtl.get("Devices"));

					// System.out.println(devarrayjson.size());
					devtlslist = processDeviceDetailsRow(jsondevdtl);
					//devtlslist.add(devicedtls);

				}
			}

			/*
			 * while (result.next()) {
			 * 
			 * }
			 */
		} catch (SQLException e) {
			System.out.println("Exception has occured" + e.getMessage());
			e.printStackTrace();

		} finally {
			DatabaseHelper.close(c);
		}
		return devtlslist;
	}

	private static List<DeviceDetails> processDeviceDetailsRow(JSONObject devdtljson) {
		List<DeviceDetails> devtlslist = new ArrayList<>();
		
		JSONArray devarrayjson = (JSONArray) devdtljson.get("Devices");
		

		for (int j = 0; j < devarrayjson.size(); j++) {
			List<VariableDetails> varList = new ArrayList<VariableDetails>();
			DeviceDetails devicedtls = new DeviceDetails();
				JSONObject devicejson = (JSONObject) devarrayjson.get(j);
				// System.out.println((Integer)devicejson.get("DeviceId"));
				devicedtls.setDeviceID(Integer.parseInt((String) devicejson.get("DeviceId")));
				devicedtls.setDeviceName((String) devicejson.get("DeviceName"));
				JSONArray vararrayjson = (JSONArray) devicejson.get("Variables");
				System.out.println(vararrayjson.size());
				
				for (int k = 0; k < vararrayjson.size(); k++) {
					
						VariableDetails vardet = new VariableDetails();
						JSONObject varjson = (JSONObject) vararrayjson.get(k);
						
						if (! StringUtils.isEmptyOrWhitespaceOnly((String)varjson.get("VariableId"))) {
							vardet.setVariableID(Integer.parseInt((String) varjson.get("VariableId")));
						}
						
						vardet.setVariableName((String) varjson.get("VariableName"));
						
						if (! StringUtils.isEmptyOrWhitespaceOnly((String)varjson.get("LatestValue"))){
							vardet.setValue(Float.parseFloat((String) varjson.get("LatestValue")));
						}
						
						
						vardet.setUrl_ON((String) varjson.get("URL_ON"));
						vardet.setUrl_OFF((String)varjson.get("URL_OFF"));
						
						if (! StringUtils.isEmptyOrWhitespaceOnly((String)varjson.get("IsSwitcher"))) {
							vardet.setIsSwitcher(Integer.parseInt((String) varjson.get("IsSwitcher")));
						}
						
						if (! StringUtils.isEmptyOrWhitespaceOnly((String)varjson.get("IsLink"))) {
							vardet.setIsLink(Integer.parseInt((String) varjson.get("IsLink")));
						}
						
						
						vardet.setTimestamp((String)varjson.get("ValueTimestamp"));
						varList.add(vardet);
		
				}
				devicedtls.setVarList(varList);
				devtlslist.add(devicedtls);
		}

		// System.out.println(result.getArray("Devices"));
		// Arrays devArray = (Arrays)result.getArray("Devices").getArray();
		// Arrays varArray = (Arrays)result.getArray("Variables").getArray();

		// System.out.println(varArray.toString());

		// devicedtls.setDeviceID(result.getInt("DeviceId"));
		// devicedtls.setDeviceName(result.getString("DeviceName"));

		return devtlslist;
	}

}
