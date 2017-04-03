package org.erian.examples.bootapi.api;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.validation.constraints.NotNull;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.erian.examples.bootapi.domain.ISSData;
import org.erian.examples.bootapi.dto.WeatherDto;
import org.erian.examples.bootapi.service.*;
import org.erian.examples.bootapi.service.exception.ErrorCode;
import org.erian.examples.bootapi.service.exception.ServiceException;
import org.erian.modules.constants.MediaTypes;
import org.erian.modules.mapper.BeanMapper;
import org.javasimon.aop.Monitored;

// Spring Restful MVC Controller的标识, 直接输出内容，不调用template引擎.
@RestController
public class WeatherController {

	private static Logger logger = LoggerFactory.getLogger(WeatherController.class);

	@Autowired
	private WeatherService weatherService;

	@RequestMapping(value = "/api/weather", method=RequestMethod.GET, produces = MediaTypes.JSON_UTF_8)
	@Monitored
	public WeatherDto listLatest(@RequestParam(value = "token", required = false) String token) {
		checkToken(token);
		ISSData data = weatherService.getLatestWeatherData(token);
		return WeatherDto.convert(data);
	}
	
	@RequestMapping(value = "/api/weather/start/{start}/end/{end}", method=RequestMethod.GET, produces = MediaTypes.JSON_UTF_8)
	@Monitored
	public List<WeatherDto> listByRange(@NotNull @PathVariable("start") @DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm:ss")  Date start, @NotNull @PathVariable("end") @DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm:ss") Date end,@RequestParam(value = "token", required = false) String token) {
		checkToken(token);
		if(start.after(end)){
			Date temp = start;
			start = end;
			end = temp;
		}
		List<ISSData> data = weatherService.listByRange(token, start, end);
		return WeatherDto.convert(data);
	}
	
	
	private void checkToken(String token) {
		if (token == null) {
			throw new ServiceException("No token in request", ErrorCode.NO_TOKEN);
		}
	}
}
