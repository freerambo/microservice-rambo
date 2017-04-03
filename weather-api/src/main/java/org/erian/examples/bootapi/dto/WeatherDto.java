package org.erian.examples.bootapi.dto;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.erian.examples.bootapi.domain.ISSData;
import org.erian.modules.mapper.BeanMapper;
import org.erian.modules.utils.Collections3;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;

public class WeatherDto {


	public int receiverRecID;

	public byte channelIndex;
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date recDateTime;

	public short dewPoint;

	public short dominantDir;

	public short et;

	public short heatIndex;

	public short hiRainRate;

	public short hiSolarRad;

	public short hiTempOut;

	public short hiUV;

	public short hiWindDir;

	public short hiWindSpeed;

	public short humOut;

	public short intervalIndex;

	public short lowTempOut;

	public short lowWindChill;

	public float rainCollectorInc;

	public short rainCollectorType;

	public short scalerAvgWindDir;

	public short solarRad;

	public short tempOut;

	public short THSWIndex;

	public short totalRainClicks;

	public short uv;

	public short windSpeed;
	
	public static WeatherDto convert(ISSData data){
		WeatherDto dto = BeanMapper.map(data, WeatherDto.class);

		dto.channelIndex = data.getId().getChannelIndex();
		dto.recDateTime = data.getId().getRecDateTime();
		dto.receiverRecID = data.getId().getReceiverRecID();
		
		return dto;
	}
	
	public static List<WeatherDto> convert(List<ISSData> datas){
		List<WeatherDto> list = null;
		if(Collections3.isNotEmpty(datas)){
			list = Lists.newArrayList();
			for(ISSData data : datas){
				list.add(convert(data));
			}
		}
		return list;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
