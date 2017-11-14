/*
 * Copyright: Energy Research Institute @ NTU
 * microservice-comm
 * org.erian.examples.bootapi.service.scheduler -> asd.java
 * Created on 10 Nov 2017-1:37:07 pm
 */
package org.erian.examples.bootapi.service.scheduler;
import java.util.Date;
import java.util.Map;
import java.util.Set;

import org.erian.examples.bootapi.service.DataPointService;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.JobKey;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.common.collect.Maps;
import com.google.common.collect.Sets;

import antlr.StringUtils;

@DisallowConcurrentExecution
public class DynamicJob  implements Job {
	
	
	private static final Set<String> jobSet = Sets.newConcurrentHashSet();
	static{
		jobSet.add("device");
		jobSet.add("project");
		jobSet.add("datapoint");
	}
	
	private final static Logger logger = LoggerFactory.getLogger(DynamicJob.class);
	
	@Autowired
	private DataPointService dpService;
	
	@Override
	public void execute(JobExecutionContext jobContext) throws JobExecutionException {
		JobKey jd = jobContext.getJobDetail().getKey();
		String group = jd.getGroup();
		String job = jd.getName();
		if( null != group && jobSet.contains(group)){
			logger.info(new Date () + " | Job  Group- " + group + "; Job -" + job);
			// process program 
//			group job 
			
			
		}else{
			logger.error(" Invalid Job group " + group + "; Job -" + job);
		}
			
		
//		logger.info(dpService.findOne(1015).toString());
	}

}