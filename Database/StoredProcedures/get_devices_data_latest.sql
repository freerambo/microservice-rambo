CREATE DEFINER=`root`@`localhost` PROCEDURE `get_devices_data_latest`()
BEGIN

-- This is important as the MySQL default setting is 1024!
SET SESSION group_concat_max_len = 500000;

SELECT CONCAT('{"Devices" : [', GROUP_CONCAT(CONCAT('{"DeviceId":"', deviceId, '", "DeviceName":"', deviceName, '", "Variables":[', list, ']}')), ']}') as jsonStr 
FROM 
(SELECT
  deviceId, deviceName,
  GROUP_CONCAT(CONCAT('{"VariableId":"', VariableId, '", "VariableName":"', VariableName, '", "LatestValue":"', IFNULL(latestValue, ''),'", "ValueTimestamp":"', IFNULL(valueTimestamp, ''),
  '", "URL_ON":"', URL_On,
  '", "URL_OFF":"', URL_Off,
  '", "IsSwitcher":"', CASE WHEN switchOnCommandId IS NOT NULL  AND switchOffCommandId IS NOT NULL 
								THEN 1 ELSE 0 
						END,
  '", "IsLink":"', CASE WHEN URL_On ='' AND   URL_OFF = ''
								THEN 0 ELSE 1 
						END,                        
  '"}')) list
FROM
  smes_microgrid_dev.device_data_view
GROUP BY
   deviceId, deviceName
   ) as LV;

END