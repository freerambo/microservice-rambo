package com.erian.microgrid.api.MicrogridApi.service;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

import com.erian.microgrid.api.MicrogridApi.dataModel.CommandData;


@RunWith(Parameterized.class)
public class CommandHelperParameterizedTest {

	private int input;
	private List<CommandData> expectedOutput;
	
	
	public CommandHelperParameterizedTest(int input, List<CommandData> expectedOutput) {
		this.input = input;
		this.expectedOutput = expectedOutput;
	}
	
	@Parameters
	public static 	Collection<List<CommandData>>  testconditions() {
		List<CommandData> list = new ArrayList<>();
		List<CommandData> list2 = new ArrayList<>();

		/*CommandData cmdData1 = new CommandData(1, "CMD1", "", "VOL {0}, CUR {1}, VOL1{2}", 1);
		CommandData cmdData2 = new CommandData(2, "CMD1", "", "VOL {0}, CUR {1}, VOL1{2}", 1);
		CommandData cmdData3 = new CommandData(3, "CMD1", "", "VOL {0}, CUR {1}, VOL1{2}", 1);
		CommandData cmdData4 = new CommandData(4, "CMD1-UPD1", "", "VOL2 {0}, CUR {1}, VOL1{2}", 1);
		CommandData cmdData5 = new CommandData(5, "NewCMD 1", "", "VOL {0}, CUR {1}", 1);
		CommandData cmdData6 = new CommandData(6, "NewCMD 2", "", "VOL {0}, CUR {1}", 1);
		CommandData cmdData7 = new CommandData(7, "CMD1-UPD3", "", "VOL2 {0}, CUR {1}, VOL1{2}", 1);
		
	    list.add(cmdData1);
	    list.add(cmdData2);
	    list.add(cmdData3);
	    list.add(cmdData4);
	    list.add(cmdData5);
	    list.add(cmdData6);
	    list.add(cmdData7);*/
	   
	    ArrayList  array = new ArrayList();
	    array.add(0, 1);
	    array.add(1, list);
	    array.add(2,56);
	    array.add(3,list2);
	
		return array;
	}
	
@Test
public void testGetAllCommandsData() {
	assertEquals(expectedOutput, CommandHelper.getAllCommandsData(input));
	assertArrayEquals(expectedOutput.toArray(), CommandHelper.getAllCommandsData(input).toArray());
}
	
	

}
