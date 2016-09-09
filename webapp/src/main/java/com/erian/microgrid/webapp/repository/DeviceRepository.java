package com.erian.microgrid.webapp.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.erian.microgrid.webapp.domain.*;

public interface DeviceRepository extends JpaRepository<Device, Long>,//
        JpaSpecificationExecutor<Device>{

}
