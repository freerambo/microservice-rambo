package com.erian.microgrid.api.MicrogridApi.service;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import com.erian.microgrid.api.MicrogridApi.dataModel.CommandData;
import static org.hamcrest.CoreMatchers.*;




public class CommandHelperTest {
	Connection conn;
	Statement stmt;
	
	@Rule
	public ExpectedException thrown = ExpectedException.none();

	@Before
	public void testOpenConnBeforeStmt() throws SQLException {
		thrown.expect(SQLException.class);
		thrown.expect(NullPointerException.class);
		thrown.expectMessage("Exception while creating DB connection");
		conn =  DatabaseHelper.getConnection();
		stmt = conn.createStatement();
	}
	
	@After
	public void testAfterConn() throws SQLException {
		thrown.expect(SQLException.class);
		thrown.expectMessage("Exception while closing statement and DB connection");
		stmt.close();
		DatabaseHelper.close(conn);
	}
	
	@Test
	public void testGetAllCommandsData() throws SQLException {
		thrown.expect(SQLException.class);
		thrown.expectMessage("Exception while excuting the statment and fetching records from DB");
		List<CommandData> cmdlist = new ArrayList<>();
		
		int deviceId = 56;
		assertTrue("DeviceId should be greater than 0", deviceId>0);
		
		
		String sql = "{call get_commands (" + deviceId + ")}";
		ResultSet rs = stmt.executeQuery(sql);
		assertTrue("no records for this deviceId", rs.next());
		while (rs.next()) {
			
			cmdlist.add(CommandHelper.processCommandRow(rs));
		}
		
	    assertThat(cmdlist, hasItems(new CommandData(1, "CMD1", "", "VOL {0}, CUR {1}, VOL1{2}", 1), 
	    		new CommandData(2, "CMD1", "", "VOL {0}, CUR {1}, VOL1{2}", 1),
	    		new CommandData(3, "CMD1", "", "VOL {0}, CUR {1}, VOL1{2}", 1),
	    		new CommandData(4, "CMD1-UPD1", "", "VOL2 {0}, CUR {1}, VOL1{2}", 1),
	    		new CommandData(5, "NewCMD 1", "", "VOL {0}, CUR {1}", 1),
	    		new CommandData(6, "NewCMD 2", "", "VOL {0}, CUR {1}", 1),
	    		new CommandData(7, "CMD1-UPD3", "", "VOL2 {0}, CUR {1}, VOL1{2}", 1)));
	
	}
	
	@Test
	//will be same assertion conditions for updateCommandData
	public void testAddNewCommandData() {
		CommandData command = new CommandData(1, "CMD1", "", "VOL {0}, CUR {1}, VOL1{2}", 1);
		
		assertFalse("id should be greater than 0", command.getID()>0);
		assertFalse("DeviceId should be greater than 0",command.getDeviceID()>0);
		//other assertions based on conditions
	}
		
}
