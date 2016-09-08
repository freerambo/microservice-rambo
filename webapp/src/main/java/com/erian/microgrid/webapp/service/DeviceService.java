package com.erian.microgrid.webapp.service;

import com.erian.microgrid.webapp.DTOUtils;
import com.erian.microgrid.webapp.domain.*;
import com.erian.microgrid.webapp.exception.ResourceNotFoundException;

import com.erian.microgrid.webapp.model.*;
import com.erian.microgrid.webapp.repository.*;

import javax.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

/**
 *
 * @author Rambo Zhu<asybzhu@gmail.com>
 */
@Service
@Transactional
public class DeviceService {

    private static final Logger log = LoggerFactory.getLogger(DeviceService.class);

    private DeviceRepository deviceRepository;

    

    @Autowired
    public void setDeviceRepository(DeviceRepository deviceRepository) {
		this.deviceRepository = deviceRepository;
	}

	public Page<DeviceDetails> searchDevicesByCriteria(String q, Device.Status status, Pageable page) {

        log.debug("search devices by keyword@" + q + ", page @" + page);

        Page<Device> devices = deviceRepository.findAll(DeviceSpecifications.filterByKeywordAndStatus(q, status),
                page);

        log.debug("get devices size @" + devices.getTotalElements());

        return DTOUtils.mapPage(devices, DeviceDetails.class);
    }

  
}
