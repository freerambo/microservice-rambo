CREATE DEFINER=`root`@`localhost` PROCEDURE `get_devices_data_latest`()
BEGIN

SELECT CONCAT('{"Devices" : [', GROUP_CONCAT(CONCAT('{"DeviceId":"', deviceId, '", "DeviceName":"', deviceName, '", "Variables":[', list, ']}')), ']}') as jsonStr 
FROM 
(SELECT
  deviceId, deviceName,
  GROUP_CONCAT(CONCAT('{"VariableId":"', VariableId, '", "VariableName":"', VariableName, '", "LatestValue":"',latestValue,'", "ValueTimestamp":"', valueTimestamp,'"}')) list
FROM
  smes_microgrid.device_data_view
GROUP BY
   deviceId, deviceName
   ) as LV;

END