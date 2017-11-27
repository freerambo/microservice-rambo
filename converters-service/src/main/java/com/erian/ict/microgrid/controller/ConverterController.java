package com.erian.ict.microgrid.controller;

import com.erian.ict.microgrid.service.ConverterService;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
public class ConverterController {

    @Autowired
    ConverterService converterService;

    @RequestMapping("/get/{deviceId}")
    public JSONObject getConverterData(@PathVariable("deviceId") String deviceId) {
        JSONObject response = new JSONObject();
        JSONObject temp;
        try {
            temp = converterService.getConverterData(deviceId);
            if (temp.get("alert")!= null) {
                response.put("alert", temp.get("alert"));
                response.put("message","ERROR");
            } else {
                response.put("data",temp);
                response.put("code", 200);
                response.put("message", "OK");
            }
        } catch (Exception e) {
            response.put("message", "ERROR");
            response.put("alert","Exception:"+ e.getMessage());
        }
        return response;
    }

    @RequestMapping(path= "/bat/droop/{deviceId}",method = RequestMethod.POST)
    public JSONObject setBatteryConverterDroopControl(@PathVariable("deviceId") String deviceId,@RequestBody JSONObject setvalues) {
        JSONObject response = new JSONObject();
        JSONObject temp;
        try {
            temp = converterService.setBatteryConverterDroopControl(deviceId,setvalues);
            if (temp.get("alert")!= null) {
                response.put("alert", temp.get("alert"));
                response.put("message","ERROR");
            } else {
                response.put("data",temp);
                response.put("code", 200);
                response.put("message", "OK");
            }
        } catch (Exception e) {
            response.put("message", "ERROR");
            response.put("alert","Exception:"+ e.getMessage());
        }

        return response;
    }

    @RequestMapping(path = "/bat/power/{deviceId}", method = RequestMethod.POST)
    public JSONObject setBatteryConverterPowerControl(@PathVariable("deviceId") String deviceId,@RequestBody JSONObject setvalues) {
        JSONObject response = new JSONObject();
        JSONObject temp;
        try {
            temp = converterService.setBatteryConverterPowerControl(deviceId,setvalues);
            if (temp.get("alert")!= null) {
                response.put("alert", temp.get("alert"));
                response.put("message","ERROR");
            } else {
                response.put("data",temp);
                response.put("code", 200);
                response.put("message", "OK");
            }
        } catch (Exception e) {
            response.put("message", "ERROR");
            response.put("alert","Exception:"+ e.getMessage());
        }

        return response;
    }

    @RequestMapping(path = "/bat/off/{deviceId}", method = RequestMethod.POST)
    public JSONObject setBatteryStatusOff(@PathVariable("deviceId") String deviceId) {
        JSONObject response = new JSONObject();
        try {
               response = converterService.setBatteryConverterOff(deviceId);

        } catch (Exception e) {
            response.put("message", "ERROR");
            response.put("alert","Exception:"+ e.getMessage());
        }
        return response;
    }

    @RequestMapping(path = "/bic/rect/{deviceId}",method = RequestMethod.POST)
    public JSONObject setBICConverterRectifier(@PathVariable("deviceId") String deviceId,@RequestBody JSONObject setvalues){
        JSONObject response = new JSONObject();
        JSONObject temp;
        try {
            temp = converterService.setBICConverterRectifier(deviceId,setvalues);
            if (temp.get("alert")!= null) {
                response.put("alert", temp.get("alert"));
                response.put("message","ERROR");
            } else {
                response.put("data",temp);
                response.put("code", 200);
                response.put("message", "OK");
            }
        } catch (Exception e) {
            response.put("message", "ERROR");
            response.put("alert","Exception:"+ e.getMessage());
        }
        return response;
    }

    @RequestMapping(path = "/bic/inverter/{deviceId}",method = RequestMethod.POST)
    public JSONObject setBICConverterInverter(@PathVariable("deviceId") String deviceId,@RequestBody JSONObject setvalues) {
        JSONObject response = new JSONObject();
        JSONObject temp;
        try {
            temp = converterService.setBICConverterInverter(deviceId,setvalues);
            if (temp.get("alert")!= null) {
                response.put("alert", temp.get("alert"));
                response.put("message","ERROR");
            } else {
                response.put("data",temp);
                response.put("code", 200);
                response.put("message", "OK");
            }
        } catch (Exception e) {
            response.put("message", "ERROR");
            response.put("alert","Exception:"+ e.getMessage());
        }
        return response;
    }

    @RequestMapping(path = "/bic/power/{deviceId}", method = RequestMethod.POST)
    public JSONObject setBICConverterPowerDispatch(@PathVariable("deviceId") String deviceId,@RequestBody JSONObject setvalues) {
        JSONObject response = new JSONObject();
        JSONObject temp;
        try {
            temp = converterService.setBICConverterPowerDispatch(deviceId,setvalues);
            if (temp.get("alert")!= null) {
                response.put("alert", temp.get("alert"));
                response.put("message","ERROR");
            } else {
                response.put("data",temp);
                response.put("code", 200);
                response.put("message", "OK");
            }
        } catch (Exception e) {
            response.put("message", "ERROR");
            response.put("alert","Exception:"+ e.getMessage());
        }
        return response;

    }

    @RequestMapping(path = "/bic/off/{deviceId}", method = RequestMethod.POST)
    public JSONObject setBICConverterOff(@PathVariable("deviceId") String deviceId) {
        JSONObject response = new JSONObject();
        try {

            response = converterService.setBICConverterOff(deviceId);

        } catch (Exception e) {
            response.put("message", "ERROR");
            response.put("alert","Exception:"+ e.getMessage());
        }
        return  response;
    }

    @RequestMapping(path = "/pv/mppt/{deviceId}/{channel}", method = RequestMethod.POST)
    public JSONObject setPVConverterMPPT(@PathVariable("deviceId") String deviceId,@PathVariable("channel") String channel) {
        String command = "";
        JSONObject response = new JSONObject();
        try {
            if ("CH1".equals(channel)) {
                command = "CH1_MPPT_TURN_ON";
            } else if ("CH2".equals(channel)) {
                command = "CH2_MPPT_TURN_ON";
            } else if ("CH3".equals(channel)){
                command = "CH3_MPPT_TURN_ON";
            }
            response = converterService.setPVConverterMPPT(deviceId,command);

        } catch (Exception e) {
            response.put("message", "ERROR");
            response.put("alert","Exception:"+ e.getMessage());
        }
        return response;
    }

    @RequestMapping(path = "/pv/off/{deviceId}/{channel}", method = RequestMethod.POST)
    public JSONObject setPVConverterChannelOff(@PathVariable("deviceId") String deviceId,@PathVariable("channel") String channel){
        String command = "";
        JSONObject response = new JSONObject();
        try {
            if ("CH1".equals(channel)) {
                command = "CH1_TURN_OFF";
            } else if ("CH2".equals(channel)) {
                command = "CH2_TURN_OFF";
            } else if ("CH3".equals(channel)){
                command = "CH3_TURN_OFF";
            }
           response = converterService.setPVConverterChannelOff(deviceId,command);

        } catch (Exception e) {
            response.put("message", "ERROR");
            response.put("alert","Exception:"+ e.getMessage());
        }
        return response;
    }

    @RequestMapping(path = "/pv/power/{deviceId}/{channel}", method = RequestMethod.POST)
    public JSONObject setPVConverterPowerDispatch(@PathVariable("deviceId") String deviceId,@RequestBody JSONObject setvalues,@PathVariable("channel") String channel) {
        JSONObject response = new JSONObject();
        JSONObject temp;
        String command = "";
        try {
            if ("CH1".equals(channel)) {
                command = "CH1_POWER_DISPATCH_TURN_ON";
            } else if ("CH2".equals(channel)) {
                command = "CH2_POWER_DISPATCH_TURN_ON";
            } else if ("CH3".equals(channel)){
                command = "CH3_POWER_DISPATCH_TURN_ON";
            }
            temp = converterService.setPVConverterPowerDispatch(deviceId,setvalues,command);
            if (temp.get("alert")!= null) {
                response.put("alert", temp.get("alert"));
                response.put("message","ERROR");
            } else {
                response.put("data",temp);
                response.put("code", 200);
                response.put("message", "OK");
            }
        } catch (Exception e) {
            response.put("message", "ERROR");
            response.put("alert","Exception:"+ e.getMessage());
        }
        return response;
    }

    @RequestMapping(path = "/status/{deviceId}", method = RequestMethod.POST)
    public JSONObject setConverterStatus(@PathVariable("deviceId") String deviceId) {
        JSONObject response = new JSONObject();
        JSONObject temp;
        String command = "";
        try {
            command = "CONNECT_CMD";
            temp = converterService.setConverterStatus(deviceId,command);
            if (temp.get("alert")!= null) {
                response.put("alert", temp.get("alert"));
                response.put("message","ERROR");
            } else {
                response.put("data",temp);
                response.put("code", 200);
                response.put("message", "OK");
            }
        } catch (Exception e) {
            response.put("message", "ERROR");
            response.put("alert","Exception:"+ e.getMessage());
        }
        return response;
    }
    
    @RequestMapping(path = "/isolate/{deviceId}", method = RequestMethod.POST)
    public JSONObject setIsolateForDevice(@PathVariable("deviceId") String deviceId) {
    	JSONObject response = new JSONObject();
        JSONObject temp;
        String command = "";
        try {
            command = "ISOLATE_CMD";
            temp = converterService.setIsolateForDevice(deviceId, command);
            if (temp.get("alert")!= null) {
                response.put("alert", temp.get("alert"));
                response.put("message","ERROR");
            } else {
                response.put("data",temp);
                response.put("code", 200);
                response.put("message", "OK");
            }
        } catch (Exception e) {
            response.put("message", "ERROR");
            response.put("alert","Exception:"+ e.getMessage());
        }
        return response;
    }
    
}
