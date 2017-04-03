package org.erian.examples.bootapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Date;
import java.util.List;

import org.erian.examples.bootapi.domain.*;
import org.erian.examples.bootapi.domain.ISSDataPK;

public interface WeatherDao extends JpaRepository<ISSData, ISSDataPK> {

	@Query(value="SELECT * FROM weather_station.ISSData order by RecDateTime desc limit 1", nativeQuery=true)
	ISSData getLatestOne();

	@Query(value="SELECT * FROM weather_station.ISSData where recdatetime between ?1 and ?2", nativeQuery=true)
	List<ISSData> listByTimeRange(Date start, Date end);
}
