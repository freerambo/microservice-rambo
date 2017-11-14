/*
 * Copyright: Energy Research Institute @ NTU
 * microservice-comm
 * org.erian.examples.bootapi.api -> wre.java
 * Created on 10 Nov 2017-1:35:34 pm
 */
package org.erian.examples.bootapi.api;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.erian.examples.bootapi.config.ConfigureQuartz;
import org.erian.examples.bootapi.service.scheduler.DynamicJob;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SimpleTrigger;
import org.quartz.Trigger;
import org.quartz.TriggerKey;
import org.quartz.impl.matchers.GroupMatcher;
import org.quartz.impl.triggers.SimpleTriggerImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.quartz.JobDetailFactoryBean;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.scheduling.quartz.SimpleTriggerFactoryBean;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Maps;


@RestController
@RequestMapping("/schedule")
public class SchedulerController {
	
	@Autowired
	private SchedulerFactoryBean schedFactory;
	
	private static final Logger logger = LoggerFactory.getLogger(SchedulerController.class);
	
	private static final Map<String,Long> freqMap = Maps.newConcurrentMap();
	static{
		freqMap.put("SEC01", 1000L);
		freqMap.put("SEC02", 2000L);
		freqMap.put("SEC03", 3000L);
		freqMap.put("SEC04", 4000L);
		freqMap.put("SEC05", 5000L);
		freqMap.put("MIN01", 60000L);
		freqMap.put("MIN02", 12000L);
		freqMap.put("MIN03", 18000L);
		freqMap.put("MIN04", 24000L);
		freqMap.put("MIN05", 30000L);
	}		
			
	@RequestMapping(name="/get",method=RequestMethod.GET)
    public String getVal(@RequestParam(value="key", defaultValue="DEFAULT") String key) throws SchedulerException {
		Map<String, String> mapOfKeyValue = new HashMap<String, String>();
		mapOfKeyValue.put(key, key);
		StringBuilder s = new StringBuilder();
		Scheduler scheduler = schedFactory.getScheduler();
		
		for (String groupName : scheduler.getJobGroupNames()) {
			     for (JobKey jobKey : scheduler.getJobKeys(GroupMatcher.jobGroupEquals(groupName))) {
				  String jobName = jobKey.getName();
				  String jobGroup = jobKey.getGroup();
				  //get job's trigger
				  List<Trigger> triggers = (List<Trigger>) scheduler.getTriggersOfJob(jobKey);
				  for(Trigger t: triggers){
					  TriggerKey tk = t.getKey();
					  Date nextFireTime = t.getNextFireTime();
					  s.append("[jobName] : " + jobName + " [groupName] : "
							+ jobGroup + " -  [triggerName] : " + tk.getName()+ " -  [triggerGroup] : "
							  + tk.getGroup() + " - startTime : " + t.getStartTime()+ " - firetime :" + nextFireTime);
					  s.append("\r\n");
				  }
		  }
	   }
		return s.toString();
    }
	
	@RequestMapping(name="/start",method=RequestMethod.POST)
	public String schedule(@RequestParam(value="job", defaultValue="DEFAULT") String job,
			 @RequestParam(value="jgroup", defaultValue="DEFAULT") String jgroup,
			 @RequestParam(value="trigger", defaultValue="DEFAULT") String trigger,
			@RequestParam(value="tgroup", defaultValue="READ") String tgroup) {
		String scheduled = "Job " + job +" and trigger "+ trigger +" is Scheduled!!";

		try {
			JobDetailFactoryBean jdfb = ConfigureQuartz.createJobDetail(DynamicJob.class);
			jdfb.setBeanName(job);
			jdfb.setGroup(jgroup);
			jdfb.afterPropertiesSet();
			
			Long freq = freqMap.get(trigger);
			if(freq == null){
				logger.error("Invalid trigger "+trigger+", please check it again!!");
				return "Invalid trigger "+trigger+", please check it again!!";
			}
			SimpleTriggerFactoryBean stfb = ConfigureQuartz.createTrigger(jdfb.getObject(),freq);
			stfb.setBeanName(trigger);
			stfb.setGroup(tgroup);
			stfb.afterPropertiesSet();
			
			schedFactory.getScheduler().scheduleJob(jdfb.getObject(), stfb.getObject());
			
		} catch (Exception e) {
			scheduled = "Could not schedule a trigger. "+ trigger + " - " + e.getMessage();
		}
		return scheduled;
	}
	@RequestMapping(name="/stop",method=RequestMethod.GET)
	public String unschedule(@RequestParam(value="job", defaultValue="DEFAULT") String job,
			 @RequestParam(value="jgroup", defaultValue="DEFAULT") String jgroup,
			 @RequestParam(value="trigger", defaultValue="DEFAULT") String trigger,
			@RequestParam(value="tgroup", defaultValue="READ") String tgroup) {
		String scheduled = "Job " + job +" and trigger "+ trigger +" is Unscheduled!!";
		
		TriggerKey tkey = new TriggerKey(trigger,tgroup);
		JobKey jkey = new JobKey(job,jgroup); 
		
		try {
			schedFactory.getScheduler().unscheduleJob(tkey);
			schedFactory.getScheduler().deleteJob(jkey);
		} catch (SchedulerException e) {
			scheduled = "Error while unscheduling " + trigger + " - " + e.getMessage();
		}
		return scheduled;
	}
}