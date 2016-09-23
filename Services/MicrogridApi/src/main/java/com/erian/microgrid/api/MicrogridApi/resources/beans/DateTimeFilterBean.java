package com.erian.microgrid.api.MicrogridApi.resources.beans;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.ws.rs.QueryParam;


public class DateTimeFilterBean {
	
	private @QueryParam("startDate") String startDate;
	private @QueryParam("endDate") String endDate;
	
	static final String DATETIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
	
	private Date parseDateTime(String dateStr) throws ParseException {
		DateFormat df = new SimpleDateFormat(DATETIME_FORMAT);
		Date ret = null;
		try {
			ret = df.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
			throw e;
		}
		
		return ret;
	}
	public Date getStartDate() throws ParseException {
		if(startDate == null)
			return null;
		return parseDateTime(startDate);
	}
	
	public Date getEndDate() throws ParseException {
		if(endDate == null)
			return null;
		return parseDateTime(endDate);
	}
	
	public String getStartDateString() {
		return startDate;
	}
	
	public String getEndDateString() {
		return endDate;
	}
	
}
