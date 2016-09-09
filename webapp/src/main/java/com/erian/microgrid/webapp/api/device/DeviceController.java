package com.erian.microgrid.webapp.api.device;

import com.erian.microgrid.webapp.Constants;
import com.erian.microgrid.webapp.domain.*;
import com.erian.microgrid.webapp.exception.InvalidRequestException;

import com.erian.microgrid.webapp.model.DeviceDetails;
import com.erian.microgrid.webapp.model.ResponseMessage;
import com.erian.microgrid.webapp.service.DeviceService;

import javax.inject.Inject;
import javax.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@RestController
@RequestMapping(value = Constants.URI_API + Constants.URI_DEVICES)
public class DeviceController {

    private static final Logger log = LoggerFactory
            .getLogger(DeviceController.class);

    private DeviceService deviceService;

    @Inject
    public DeviceController(DeviceService deviceService) {
        this.deviceService = deviceService;
    }

    @RequestMapping(value = "", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<Page<DeviceDetails>> getAllDevices(
            @RequestParam(value = "q", required = false) String keyword, //
            @RequestParam(value = "bus", required = false) Device.Bus bus, //
            @PageableDefault(page = 0, size = 5, sort = "id", direction = Direction.ASC) Pageable page) {

        log.warn("get all posts of q@" + keyword + ", bus @" + bus + ", page@" + page);

        Page<DeviceDetails> posts = deviceService.searchDevicesByCriteria(keyword, bus, page);

        log.debug("get posts size @" + posts.getTotalElements());

        return new ResponseEntity<>(posts, HttpStatus.OK);
    }

   
}
