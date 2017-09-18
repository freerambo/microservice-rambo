package org.erian.examples.bootapi.service.scheduler;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.erian.examples.bootapi.domain.DataPoint;
import org.erian.examples.bootapi.domain.DataPointValue;
import org.quartz.CronScheduleBuilder;
import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerContext;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

/**
 * function description：Scheduler to store the data point values regularly according to 
 * user configuration in the DataPoint interval setting
 *
 * @author <a href="mailto:chenwoon.thong@ntu.edu.sg">JT  </a>
 * @version v 1.0 
 * Create:  18 Sep 2017 11:30:28 pm
 */

@Component
public class ConfiguredScheduler implements Job {
	//private static String apiUrl = "http://localhost:8080/api/dp/read/";
    //private static final String postUrl = "http://localhost:8080/api/dpv";
    private static String dpUrl = "http://172.21.76.225:8080/api/dp/read/";
    private static final String dpvUrl = "http://172.21.76.225:8080/api/dpv";
    private final static String dpsUrl = "http://172.21.76.225:8080/api/dataPoints";
    
	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
        SchedulerContext schedulerContext = null;
        try {
            schedulerContext = context.getScheduler().getContext();
        } catch (SchedulerException e1) {
            e1.printStackTrace();
        }
        
        /* Get the list of DataPoint objects and poll the data */
    	List<DataPoint> dps = (List<DataPoint>) schedulerContext.get("configuredInterval");
    	Iterator<DataPoint> dpsIterator = dps.iterator();
    	while (dpsIterator.hasNext()) {
    		DataPoint dp = dpsIterator.next();
    		dpUrl = dpUrl + dp.id.toString();
    		RestTemplate restTemplate = new RestTemplate();
    		
    		try {
    			ResponseEntity<String> response = restTemplate.getForEntity(dpUrl, String.class);
    			String value = response.getBody();
    			DataPointValue dpv = new DataPointValue();
    			dpv.dataPointId = dp.id;
    			dpv.value = value;
    			dpv.timestamp = new Date();
    			RestTemplate restPostTemplate = new RestTemplate();
    			ResponseEntity<String> postResp = restPostTemplate.postForEntity(dpvUrl, dpv, String.class);
    			System.out.println(postResp);
    		} catch (RestClientException e) {
    			e.printStackTrace();
    		}
    		
    	}
    	
	}
	
	/* Setup the scheduler for user configured interval. This code does not need to be here */ 
	public void setup() {
		List<DataPoint> dataPointSec05 = new ArrayList<DataPoint>();
		List<DataPoint> dataPointMin01 = new ArrayList<DataPoint>();
		List<DataPoint> dps = fetchDataPointsFromAPI();
		Iterator<DataPoint> dpsIterator = dps.iterator();
		while (dpsIterator.hasNext()) {
			DataPoint dp = dpsIterator.next();
			switch(dp.interval) {
				case "SEC05":
					dataPointSec05.add(dp);
					break;
				case "MIN05":
					dataPointMin01.add(dp);
					break;
			}
		}
		
		/* Scheduler Job for 5 seconds interval */
		JobKey jobSchedulerSec05 = new JobKey("configuredScheduler", "group1");
		JobDetail schedulerServiceSec05 = JobBuilder.newJob(ConfiguredScheduler.class)
	    		.withIdentity(jobSchedulerSec05).build();
		
		Trigger triggerSec05 = TriggerBuilder
    			.newTrigger()
    			.withIdentity("configuredSchedulerSec05", "group1")
    			.withSchedule(
    				CronScheduleBuilder.cronSchedule("0/5 * * * * ?"))
    			.build();
		try {
			Scheduler schedulerSec05 = new StdSchedulerFactory().getScheduler();
			schedulerSec05.getContext().put("configuredInterval", dataPointSec05);
			schedulerSec05.start();
			schedulerSec05.scheduleJob(schedulerServiceSec05, triggerSec05);
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		
		/* Scheduler Job for 1 minute interval */
		JobKey jobSchedulerMin01 = new JobKey("configuredScheduler", "group1");
		JobDetail schedulerServiceMin01 = JobBuilder.newJob(ConfiguredScheduler.class)
	    		.withIdentity(jobSchedulerMin01).build();
		
		Trigger triggerMin01 = TriggerBuilder
    			.newTrigger()
    			.withIdentity("configuredSchedulerMin05", "group1")
    			.withSchedule(
    				CronScheduleBuilder.cronSchedule("0 0/1 * * * ?"))
    			.build();
		try {
			Scheduler schedulerMin01 = new StdSchedulerFactory().getScheduler();
			schedulerMin01.getContext().put("configuredInterval", dataPointMin01);
			schedulerMin01.start();
			schedulerMin01.scheduleJob(schedulerServiceMin01, triggerMin01);
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		
		
	}

	/* Get the list of DataPoint in an array. This method does not need to be here */
	private List<DataPoint> fetchDataPointsFromAPI() {
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<DataPoint[]> response = restTemplate.getForEntity(
	            dpsUrl, 
	            DataPoint[].class
	        );
	    DataPoint[] dataPoints = response.getBody();
	    return Arrays.asList(dataPoints);

	}
	
}
