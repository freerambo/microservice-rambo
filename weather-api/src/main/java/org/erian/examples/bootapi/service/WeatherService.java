package org.erian.examples.bootapi.service;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.annotation.PostConstruct;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.actuate.metrics.CounterService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.erian.examples.bootapi.domain.*;
import org.erian.examples.bootapi.repository.*;
import org.erian.examples.bootapi.service.exception.ErrorCode;
import org.erian.examples.bootapi.service.exception.ServiceException;
import org.erian.modules.utils.Digests;
import org.erian.modules.utils.Encodes;
import org.erian.modules.utils.Ids;

import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import com.google.common.collect.Maps;

// Spring Bean的标识.
@Service
public class WeatherService {

	private static Logger logger = LoggerFactory.getLogger(WeatherService.class);

	@Autowired
	private WeatherDao weatherDao;

	// 注入配置值
	@Value("${app.loginTimeoutSecs:600}")
	private int loginTimeoutSecs;

	// codehale metrics
	@Autowired
	private CounterService counterService;

	// guava cache
	private Map<String, String> loginUsers = Maps.newConcurrentMap();
	// guava cache
	private Cache<String, Object> results;

	@Value(value = "${setToken:erian_internal_use}")
	private String setToken;
	@PostConstruct
	public void init() {
		loginUsers.put(setToken, "ERI@N_Internal_Use");
		results =  CacheBuilder.newBuilder().maximumSize(1000).expireAfterAccess(60, TimeUnit.SECONDS)
				.build();
		
	}
	
	public ISSData getLatestWeatherData(String token) {

		String account = loginUsers.get(token);

		if (account == null) {
			throw new ServiceException("Invalid token", ErrorCode.UNAUTHORIZED);
		}
		
		ISSData data =  (ISSData)results.getIfPresent(token);

		if (data == null) {
			data = weatherDao.getLatestOne();
		} 
		
		if (data == null) {
			throw new ServiceException("No data respond", ErrorCode.NO_DATA);
		}else{
			results.put(token, data);
		}
		
		return data;
	}
	
	public List<ISSData> listByRange(String token,Date start, Date end) {

		String account = loginUsers.get(token);

		if (account == null) {
			throw new ServiceException("Invalid token", ErrorCode.UNAUTHORIZED);
		}
		
		@SuppressWarnings("unchecked")
		List<ISSData> data = (List<ISSData>)results.getIfPresent(start.toString()+end.toString());

		if (data == null) {
			data = weatherDao.listByTimeRange(start,end);
		} 
		
		if (data == null) {
			logger.warn("No data respond");
		}else{
			results.put(start.toString()+end.toString(), data);
		}
		
		return data;
	}
	
	

}
